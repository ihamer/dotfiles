files=( .inputrc .bash_profile .bashrc .vimrc .vim )

for f in "${files[@]}"; do
  if [ -h $f ]; then
    rm $f
  else
    if [ -e $f ]; then
      echo "Moving $f to $f.saved"
      mv $f $f.saved
    fi
  fi
  
  ln -s .dotfiles/$f $f
done

