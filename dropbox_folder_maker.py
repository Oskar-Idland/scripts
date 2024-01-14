import dropbox
import webbrowser
import base64
import requests
import json
from termcolor import cprint


TOKEN = 'sl.BXwDzSv36QH-bc0THU7-JI7GHcVr94OL4BfBb1f1y_D6oECzWPlK5S9kDuSahme7JDz2tmotKWCyLpr4q5iD-sATh95qnPSYQIP3RCK27oMxSRt4WdJnpS-i8vF3rl_AtpiZ85nRWsGX'
# TOKEN Generated from dropbox
APP_KEY = 'r1j4nm2qujcwk9w'
APP_SECRET = 'io0za5hhmqkzkxl'
ACCESS_CODE_GENERATED = 'ZfkvIzibxoIAAAAAAAAEyk0DK5HLBVNZBevM1XuwwGo'
REFRESH_TOKEN = 'EHyU-wxjJicAAAAAAAAAAYIxO8gmpP1Dek7l2wRp-iJmDxfJdQ8oailCKj3lnIAx'

ÅR = 2024
FOLDER_PATH = f"/Mobile Uploads/{ÅR}"




def get_access_code():
    '''Gets ACCESS_CODE_GENERATED in browser'''
    url = f'https://www.dropbox.com/oauth2/authorize?client_id={APP_KEY}&' \
      f'response_type=code&token_access_type=offline'
    
    webbrowser.open(url)
    
def get_refresh_token():
    '''Gets refresh token which is printed in a dictionary in the terminal. This only needs to be done once. '''
    BASIC_AUTH = base64.b64encode(f'{APP_KEY}:{APP_SECRET}'.encode())

    headers = {
        'Authorization': f"Basic {BASIC_AUTH}",
        'Content-Type': 'application/x-www-form-urlencoded',
    }

    data = f'code={ACCESS_CODE_GENERATED}&grant_type=authorization_code'

    response = requests.post('https://api.dropboxapi.com/oauth2/token',
                            data=data,
                            auth=(APP_KEY, APP_SECRET))
    print(json.dumps(json.loads(response.text), indent=2))
    print(json.dumps(json.loads(response.text), indent=2).split('"')[1])
    

# Establish connection
def connect_to_dropbox(TOKEN = TOKEN):
    
    try:
        DBX = dropbox.Dropbox(app_key = APP_KEY,
                              app_secret = APP_SECRET,
                              oauth2_refresh_token = TOKEN)
        
        print('Connected to Dropbox successfully')
      
    except Exception as e:
        print(str(e))
      
    return DBX
  


def list_files_in_folder(DBX):
    
    # here DBX is an object which is obtained
    # by connecting to dropbox via TOKEN
      
    try:  
        # DBX object contains all functions that 
        # are required to perform actions with dropbox
        files = DBX.files_list_folder(FOLDER_PATH).entries
        print(f"------------ Listing Files in Folder '{ÅR}' ------------")
          
        for file in files:
            # listing
            print(file.name)
              
    except Exception as e:
        print('-------------------------------')
        print('Error! Could not list files in folder')
        print(str(e))
  

def generate_folders(DBX, uker):
    nye_uker = []
    for uke in uker.split():
        uke = int(uke)
        try:
            main_str = f'/Mobile Uploads/{ÅR}/Uke {uke}'
            
            DBX.files_create_folder_v2(main_str)

            DBX.files_create_folder_v2(f'{main_str}/01 mandag uke {uke}')
            DBX.files_create_folder_v2(f'{main_str}/02 tirsdag uke {uke}')
            DBX.files_create_folder_v2(f'{main_str}/03 onsdag uke {uke}')
            DBX.files_create_folder_v2(f'{main_str}/04 torsdag uke {uke}')
            DBX.files_create_folder_v2(f'{main_str}/05 fredag uke {uke}')

            nye_uker.append(f'Uke {uke}'
            )
        except Exception as e:
            if "CreateFolderError('path', WriteError('conflict', WriteConflictError('folder', None))))" in str(e):
                print()
                print('Folder already exists!!!!')
                files = DBX.files_list_folder(FOLDER_PATH).entries
                print(f"------------ Listing Files in Folder '{ÅR}' ------------ ")
                
                for file in files:
                    if file.name == f'Uke {uke}':
                        cprint(f'{file.name} <- Look here dumbo', "red", attrs=["bold"])
                    else:
                        # listing
                        print(file.name)
            else:
                print('Error! Could not create folders')
                print('-------------------------------')
                print(e)

    print()
    cprint(f'Folders created successfully', "green", attrs=["bold"])
    print(f"------------ Listing Files in Folder '{ÅR}' ------------ ")
    files = DBX.files_list_folder(FOLDER_PATH).entries
    for file in files:
        if file.name in nye_uker:
            cprint(f'{file.name} <-', "green", attrs=["bold"])
        else:
            # listing
            print(file.name)
            
if __name__ == '__main__':
    # get_access_code()
    # REFRESH_TOKEN = get_refresh_token()
    DBX = connect_to_dropbox(REFRESH_TOKEN)
    list_files_in_folder(DBX)
    uker = input('Uke(r): ')
    generate_folders(DBX, uker)
