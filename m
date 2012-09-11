From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 23:50:47 +0200
Message-ID: <CAMwB3Th06AF=BigLifBusJQZXj7+HOS_D3JcwYjj9sVjGyMw3Q@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
	<CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
	<CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com>
	<CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
	<CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
	<CAC-hyiFiL4yX75NNLPEaxt6XbLZj5YLnzi5Fk5oidUwy2ooGPw@mail.gmail.com>
	<CAMwB3Th5wjGeQsDxv2aCXvwsUk-hw_-_Cs+WyvwpbN9N1wGdiw@mail.gmail.com>
	<CAC-hyiF--FVokkNNO0mzWr3sFJL0xqv5h6uZKrzW3TQX-3rXpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51256 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab2IKVus convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:50:48 -0400
Received: by qcro28 with SMTP id o28so605808qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:50:48 -0700 (PDT)
In-Reply-To: <CAC-hyiF--FVokkNNO0mzWr3sFJL0xqv5h6uZKrzW3TQX-3rXpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

Ehh my ideas run out for this day.

libs3                            2.0-1

s3 -u create foo

Bucket successfully created.

s3 -u getacl foo | s3 -u setacl ocdn < /tmp/acl

ERROR: ErrorAccessDenied


ERROR: ErrorAccessDenied

On Tue, Sep 11, 2012 at 11:44 PM, Yehuda Sadeh <yehuda@inktank.com> wro=
te:
> Maybe your s3 library got updated and now uses a newer s3 dialect?
>
> Basically you need to update the bucket acl, e.g.:
>
> # s3 -u create foo
> # s3 -u getacl foo | s3 -u setacl oldbucket < acl
>
> On Tue, Sep 11, 2012 at 2:38 PM, S=B3awomir Skowron <szibis@gmail.com=
> wrote:
>> Ok, but why this happend. There is no new code started before this
>> problem. Is there any way to recover cluster to normal operation
>> withoud Access Denied in s3 any acl operation ??
>>
>> On Tue, Sep 11, 2012 at 11:32 PM, Yehuda Sadeh <yehuda@inktank.com> =
wrote:
>>> On Tue, Sep 11, 2012 at 2:28 PM, S=B3awomir Skowron <szibis@gmail.c=
om> wrote:
>>>> :~# s3 -u put ocdn/test3 cannedAcl=3Dpublic-read < /tmp/testdl
>>>> :~# s3 -u get ocdn/test3 > /tmp/test3
>>>> :~# HEAD http://127.0.0.1/ocdn/test3
>>>> 200 OK
>>>> Connection: close
>>>> Date: Tue, 11 Sep 2012 21:23:19 GMT
>>>> Accept-Ranges: bytes
>>>> ETag: "a241f32b8cf07f90d36b5199629b8829"
>>>> Server: nginx
>>>> Content-Length: 6713
>>>> Last-Modified: Tue, 11 Sep 2012 21:22:48 GMT
>>>> Client-Date: Tue, 11 Sep 2012 21:23:19 GMT
>>>> Client-Peer: 127.0.0.1:80
>>>> Client-Response-Num: 1
>>>>
>>>> put with cannedacl forpublic works on this object.
>>>>
>>> As it should. I was referring to setacl with canned acl.
>>>
>>> Yehuda
>>
>>
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=B3awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
