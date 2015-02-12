From: GuangYang <yguang11@outlook.com>
Subject: RE: Upgrade/rollback
Date: Thu, 12 Feb 2015 08:48:08 +0000
Message-ID: <BLU175-W18F0FC1C0DF61C25BEFCEDF220@phx.gbl>
References: <BLU175-W8D101EDE23DCDD591ADF6DF250@phx.gbl>
 <CAC6JEv_76meAsaRmCr9-qEiU0C0R4LGOx=ja9M5vxkW=6jSvcQ@mail.gmail.com>,<alpine.DEB.2.00.1502110923250.3035@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc2s8.hotmail.com ([65.55.111.83]:62884 "EHLO
	BLU004-OMC2S8.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbbBLIsJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 03:48:09 -0500
In-Reply-To: <alpine.DEB.2.00.1502110923250.3035@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage and Greg for the response.

> 2) having a separate switchover point (besides the code upgrade) whic=
h
> =A0enables all the disk change bits and which doesn't allow you to ro=
ll
> =A0back.
Let me give two examples which prevent us rollback from Giant to Firefl=
y.

Example #1:
In Giant, there is a new feature flag 'CEPH_FEATURE_ERASURE_CODE_PLUGIN=
S_V2' added/persisted, and monitor would =A0check the persisted list ag=
ainst the list released along with the software version upon starting, =
it refuse to start if the list mismatch. However, although the feature =
is added in Giant, it is not being used until we create a new pool with=
 the profile, which is very unlikely to happen.
1) is it possible to persist the new feature bit when the feature is be=
ing used (this looks like complicated to implement). 2) When loading th=
e persisted bit, is it possible to check if it is actually used by some=
one?

Example #2:
Patch [1] added a new k/v to the PG log which cannot be recognized by o=
ld version of binary (PGLog::read_log), as a result, it takes the newly=
 added entry as a pg_log_entry.
Is it possible to recognize pg_log_entry with a concrete pattern and ju=
st ignore those that the binary cannot recognize?


=46or there two cases, we may be able to erase the newly added entries =
and then roll back (correct me if I am wrong here), but I think there m=
ight be more complicated cases which make the rollback impossible. And =
accept that risk for upgrading.

[1]=A0httpsgithub.com/ceph/ceph/commit/1fe8b846641486cc294fe7e1d2450132=
c38d2dba

Thanks,
Guang


----------------------------------------
> Date: Wed, 11 Feb 2015 09:26:14 -0800
> From: sage@newdream.net
> To: greg@gregs42.com
> CC: yguang11@outlook.com; ceph-devel@vger.kernel.org
> Subject: Re: Upgrade/rollback
>
> On Wed, 11 Feb 2015, Gregory Farnum wrote:
>> On Wed, Feb 11, 2015 at 4:09 AM, GuangYang <yguang11@outlook.com> wr=
ote:
>>> Hi ceph-devel,
>>> Recently we are trying the upgrade from Firefly to Giant and it goe=
s pretty smoothly, however, the problem is that it does not support rol=
lback and seems like that is by design. For example, there is new featu=
re flag / metadata [1] added in the new version and they are persisted.=
 As a result, the old version of software does not recognize those valu=
es and will crash themselves.
>>>
>>> Ideally we never rollback, but for unknown reasons we couldn't fix =
in a timely manner, we might want to rollback first. Is that something =
we will consider to handle?
>>
>> We are unlikely to ever do this. We've talked about rollback options=
,
>> but allowing rollback means either:
>> 1) never adding information to the disk format which matters,
>> 2) having a separate switchover point (besides the code upgrade) whi=
ch
>> enables all the disk change bits and which doesn't allow you to roll
>> back.
>>
>> The first option is obviously infeasible. The second one dramaticall=
y
>> increases the amount of code which can be buggy, increases the testi=
ng
>> version, and doesn't really solve the problem since you still have a
>> hard point of no return.
>
> The only rollback plan we do have currently is to start testing and
> supporting rollback within a major release, e.g. 0.80.8 -> 0.80.7. We
> (normally) don't add any incompatible changes within a stable release=
 so
> this won't be a major change except that right now none of the downgr=
ade
> scenarios are tested.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
