From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RadowGW and multiple parts upload
Date: Fri, 1 Feb 2013 09:38:50 -0800
Message-ID: <CAC-hyiHi-GoPcjj+A08OjKdsQZiLf6c02mdyC+zPxT5jnU2CSA@mail.gmail.com>
References: <CAJH6TXgfL8CVKyV71fsobi6e=AxOWZczbZa-TjosYodGJCbzEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:51420 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3BARiv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 12:38:51 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so2670722ieb.25
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 09:38:50 -0800 (PST)
In-Reply-To: <CAJH6TXgfL8CVKyV71fsobi6e=AxOWZczbZa-TjosYodGJCbzEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Feb 1, 2013 at 8:50 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> I'm having trouble trying to upload a 300MB file.
> I'm using the S3 SDK for Android and it will try to upload in chuncks of 5MB
>
> First chunk is uploaded properly (status code 200), but all next
> chunks are getting error 400 (Bad Request)
>
> This is the query string that i'm seeing in apache error log
>
> envp=QUERY_STRING=page=20120908_173724.mp4&params=&uploadId=oewbStwXmRLzXBYtxhEKhUwfs93S-6j&partNumber=2
>
> This is from radosgw.log:
>
> 2013-02-01 17:45:09.816931 7fe06fdf6700 20 get_obj_state:
> rctx=0x1199b20 obj=x:_multipart_20120908_173724.mp4.oewbStwXmRLzXBYtxhEKhUwfs93S-6j.2
> state=0x1947e98 s->prefetch_data=0
> 2013-02-01 17:45:09.830013 7fe056dc4700  2 req 123:0.809200:s3:PUT
> /x/20120908_173724.mp4:put_obj:http status=400
> 2013-02-01 17:45:09.830104 7fe056dc4700  1 ====== req done
> req=0x19147c0 http_status=400 ======
> 2013-02-01 17:45:09.831012 7fe0455a1700 20 get_obj_state: s->obj_tag
> was set empty
> 2013-02-01 17:45:09.831019 7fe0455a1700 20
> prepare_atomic_for_write_impl: state is not atomic. state=0x19297c8
> 2013-02-01 17:45:09.893427 7fe06fdf6700 20 get_obj_state: s->obj_tag
> was set empty
> 2013-02-01 17:45:09.893434 7fe06fdf6700 20
> prepare_atomic_for_write_impl: state is not atomic. state=0x1947e98
> 2013-02-01 17:45:10.130338 7fe05a5cb700  2 req 120:1.299782:s3:PUT
> /x/20120908_173724.mp4:put_obj:http status=400

Can you send the full log of the request? Also, can you turn on 'debug ms = 1'?

Thanks,
Yehuda
