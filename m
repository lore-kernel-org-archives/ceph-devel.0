From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Using valgrind_osd option
Date: Tue, 09 Jul 2013 20:15:02 -0500
Message-ID: <51DCB596.4040800@inktank.com>
References: <CA+bvTtnt_GZEiwHgsmW_uWvjhFxE3QxyUTWX=nM6hs5E6ikLuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:58720 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3GJBPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 21:15:05 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so3487455qeb.30
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jul 2013 18:15:04 -0700 (PDT)
In-Reply-To: <CA+bvTtnt_GZEiwHgsmW_uWvjhFxE3QxyUTWX=nM6hs5E6ikLuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ranjan Sarpangala Venkatesh <ranjansv@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

Hi,

I ran into this problem a while back and it was because I was trying to 
use a version of valgrind that didn't support tcmalloc (which Ceph was 
compiled to use).  Try upgrading valgrind to 3.8.0 or newer.  You'll 
also need to pass something like:

--soname-synonyms=somalloc=*tcmalloc*

Mark

On 07/09/2013 08:10 PM, Ranjan Sarpangala Venkatesh wrote:
> Hi,
>
> I am trying to collect memory of the OSD daemon with the following
>
> ./vstart.sh -n -x -l --valgrind_osd 'massif'
>
> However, when I print massif.out file there is nothing
>
> cat massif.out.15391
>
> desc: (none)
> cmd: ./ceph-osd -i 0 -c ceph.conf -f
> time_unit: i
> #-----------
> snapshot=0
> #-----------
> time=0
> mem_heap_B=0
> mem_heap_extra_B=0
> mem_stacks_B=0
> heap_tree=empty
>
> --
> With regards,
> Ranjan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

