From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 23:38:21 +0200
Message-ID: <CAMwB3Th5wjGeQsDxv2aCXvwsUk-hw_-_Cs+WyvwpbN9N1wGdiw@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
	<CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
	<CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com>
	<CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
	<CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
	<CAC-hyiFiL4yX75NNLPEaxt6XbLZj5YLnzi5Fk5oidUwy2ooGPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:55441 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab2IKViW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:38:22 -0400
Received: by qaas11 with SMTP id s11so631388qaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:38:21 -0700 (PDT)
In-Reply-To: <CAC-hyiFiL4yX75NNLPEaxt6XbLZj5YLnzi5Fk5oidUwy2ooGPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Ok, but why this happend. There is no new code started before this
problem. Is there any way to recover cluster to normal operation
withoud Access Denied in s3 any acl operation ??

On Tue, Sep 11, 2012 at 11:32 PM, Yehuda Sadeh <yehuda@inktank.com> wro=
te:
> On Tue, Sep 11, 2012 at 2:28 PM, S=B3awomir Skowron <szibis@gmail.com=
> wrote:
>> :~# s3 -u put ocdn/test3 cannedAcl=3Dpublic-read < /tmp/testdl
>> :~# s3 -u get ocdn/test3 > /tmp/test3
>> :~# HEAD http://127.0.0.1/ocdn/test3
>> 200 OK
>> Connection: close
>> Date: Tue, 11 Sep 2012 21:23:19 GMT
>> Accept-Ranges: bytes
>> ETag: "a241f32b8cf07f90d36b5199629b8829"
>> Server: nginx
>> Content-Length: 6713
>> Last-Modified: Tue, 11 Sep 2012 21:22:48 GMT
>> Client-Date: Tue, 11 Sep 2012 21:23:19 GMT
>> Client-Peer: 127.0.0.1:80
>> Client-Response-Num: 1
>>
>> put with cannedacl forpublic works on this object.
>>
> As it should. I was referring to setacl with canned acl.
>
> Yehuda



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
