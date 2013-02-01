From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: RadowGW and multiple parts upload
Date: Fri, 1 Feb 2013 17:50:00 +0100
Message-ID: <CAJH6TXgfL8CVKyV71fsobi6e=AxOWZczbZa-TjosYodGJCbzEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44295 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757081Ab3BAQuC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 11:50:02 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so310908wie.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 08:50:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm having trouble trying to upload a 300MB file.
I'm using the S3 SDK for Android and it will try to upload in chuncks of 5MB

First chunk is uploaded properly (status code 200), but all next
chunks are getting error 400 (Bad Request)

This is the query string that i'm seeing in apache error log

envp=QUERY_STRING=page=20120908_173724.mp4&params=&uploadId=oewbStwXmRLzXBYtxhEKhUwfs93S-6j&partNumber=2

This is from radosgw.log:

2013-02-01 17:45:09.816931 7fe06fdf6700 20 get_obj_state:
rctx=0x1199b20 obj=x:_multipart_20120908_173724.mp4.oewbStwXmRLzXBYtxhEKhUwfs93S-6j.2
state=0x1947e98 s->prefetch_data=0
2013-02-01 17:45:09.830013 7fe056dc4700  2 req 123:0.809200:s3:PUT
/x/20120908_173724.mp4:put_obj:http status=400
2013-02-01 17:45:09.830104 7fe056dc4700  1 ====== req done
req=0x19147c0 http_status=400 ======
2013-02-01 17:45:09.831012 7fe0455a1700 20 get_obj_state: s->obj_tag
was set empty
2013-02-01 17:45:09.831019 7fe0455a1700 20
prepare_atomic_for_write_impl: state is not atomic. state=0x19297c8
2013-02-01 17:45:09.893427 7fe06fdf6700 20 get_obj_state: s->obj_tag
was set empty
2013-02-01 17:45:09.893434 7fe06fdf6700 20
prepare_atomic_for_write_impl: state is not atomic. state=0x1947e98
2013-02-01 17:45:10.130338 7fe05a5cb700  2 req 120:1.299782:s3:PUT
/x/20120908_173724.mp4:put_obj:http status=400
