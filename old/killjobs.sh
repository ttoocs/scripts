for i in `jobs -p`; do
kill $i
done
sleep 1;
for i in `jobs -p`; do
kill -9 $i
done
