
T=""
for i in {0..10}; do
  S=$(( $RANDOM % 2))
  if [ $S == 0 ]; then
    T=$T's'
  else
    T=$T'h'
  fi
done

echo $T
read U 

if [ "$T" == "$U" ]; then
  echo "WIN."
else
  echo "LOSE."
fi
