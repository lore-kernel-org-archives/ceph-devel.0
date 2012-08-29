From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Unable to set pg_num property of pool "data"
Date: Wed, 29 Aug 2012 11:51:52 +0200
Message-ID: <503DE638.9020002@widodh.nl>
References: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:55298 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab2H2Jvz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 05:51:55 -0400
In-Reply-To: <CAGfy=6n9X87iOwJjT3n3WuBRSxmUS6LnL27v0H10=SJ4YG5f0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2012 11:42 AM, hemant surale wrote:
> Hi Ceph Community ,
>       I am facing problem while I am explicitly  trying to set
> "pg_number" of "data" pool.
>
> --------------------------------------------------------------------------------------------------------------------
> root@third-virtual-machine:~# ceph osd pool set data pg_num 100
> 2012-08-29 15:08:52.388446 mon <- [osd,pool,set,data,pg_num,100]
> 2012-08-29 15:08:52.388924 mon0 -> 'specified pg_num 100 <= current 200' (-22)
>

Could you show us the output of the following command?

$ ceph osd dump -o -|grep pg_num

It seems like you are trying to decrease the number of PGs?

>
> root@third-virtual-machine:~# ceph osd pool get data pg_num
> 2012-08-29 15:09:04.788365 mon <- [osd,pool,get,data,pg_num]
> 2012-08-29 15:09:04.788833 mon0 -> 'PG_NUM: 200' (0)
>
> -----------------------------------------------------------------------------------------------------------------
> Why is it not working to set pg_number to 100. The cmd is executed
> while ceph is running.
> (ceph v. 0.36, ubuntu 11.10)
>

I recommend upgrading to Ubuntu 12.04.1 with Ceph 0.48.1

Wido

>
> Regards,
> hemant surale.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

