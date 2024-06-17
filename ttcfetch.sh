#!/bin/bash

# Replace with the absolute path for your the TTC addon directory (usually it's in <path to steam library>/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/My Documents/Elder Scrolls Online/live/AddOns/TamrielTradeCentre)
TTC_PATH="$HOME/.local/share/Steam/steamapps/compatdata/306130/pfx/drive_c/users/steamuser/My Documents/Elder Scrolls Online/live/AddOns/TamrielTradeCentre/"

echo -e "\e[35m================================================================================\e[0m"

echo -e "\e[32mChanging to Downloads folder...\e[0m"
cd "$HOME/Downloads/" &&

echo -e "\e[32mDownloading TTC PriceTables for EU...\e[0m"
# Replace url with the pricetable for the server you want.
wget https://eu.tamrieltradecentre.com/download/PriceTable &&

# The destination path changes depending on how you have ESO installed !!!
echo -e "\e[32mUnziping the PriceTable and moving it to TamrielTradeCentre addon folder...\e[0m"
unzip -o PriceTable -d "$TTC_PATH" &&

echo -e "\n\e[32mDeleting the Pricetable file from Downloads...\e[0m"
rm "$HOME/Downloads/PriceTable" &&

echo -e "\n\e[32mFINISHED!!\e[0m\n"

echo -e "\e[35m================================================================================\e[0m"
