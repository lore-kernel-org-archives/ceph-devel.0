From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 14:32:11 -0700
Message-ID: <CAC-hyiFiL4yX75NNLPEaxt6XbLZj5YLnzi5Fk5oidUwy2ooGPw@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
	<CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
	<CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com>
	<CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
	<CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49616 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab2IKVcN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:32:13 -0400
Received: by eaac11 with SMTP id c11so505152eaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:32:12 -0700 (PDT)
In-Reply-To: <CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 2:28 PM, S=C5=82awomir Skowron <szibis@gmail.co=
m> wrote:
> :~# s3 -u put ocdn/test3 cannedAcl=3Dpublic-read < /tmp/testdl
> :~# s3 -u get ocdn/test3 > /tmp/test3
> :~# HEAD http://127.0.0.1/ocdn/test3
> 200 OK
> Connection: close
> Date: Tue, 11 Sep 2012 21:23:19 GMT
> Accept-Ranges: bytes
> ETag: "a241f32b8cf07f90d36b5199629b8829"
> Server: nginx
> Content-Length: 6713
> Last-Modified: Tue, 11 Sep 2012 21:22:48 GMT
> Client-Date: Tue, 11 Sep 2012 21:23:19 GMT
> Client-Peer: 127.0.0.1:80
> Client-Response-Num: 1
>
> put with cannedacl forpublic works on this object.
>
As it should. I was referring to setacl with canned acl.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
