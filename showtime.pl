use LWP::UserAgent;
$ua = LWP::UserAgent->new;


#$input=<STDIN>;
#print $input;

#get url
    $res = $ua->get("http://www.atmovies.com.tw/showtime/theater_t06608_a06.html") ;

#exception
if ($res->is_success) {
    
    $tmpstring = $res->content;
    $tmpstring =~ s/\n//g;#去掉換行元素
    $tmpstring =~ s/\s+//g;#去掉空白元素
    #print $res->content;#test content
    
    #先抓showtime_box和end之間
    while($tmpstring =~ /(showtime_box)(.*?)(end)(.*)/x)
    {
        $linumb = $2;#之間的就是要抓的內容
        $tmpstring = $4;#之後的為剩下的讓loop繼續進行
        #print $linumb; #test re
        #把片名抓出來
        #分兩個範圍抓
        if($linumb =~ /(ahref)(.*?)(a><)/)
        {
            $tmpli = $2;
            if($tmpli =~ /(>)(.*?)(<)/)
            {
          print "$2 \n";
            }
        }
        
        #將片名連接的時刻表抓出
        while($linumb =~ /(<LI>)(.*?)(<)(.*)/ox)
        {
        print "$2\n";
        $linumb = $4;
        }
        
        #print "\ncorrect1\n";#test loop
    }

}
else {
    print $res->status_line, "\n";
}



exit;