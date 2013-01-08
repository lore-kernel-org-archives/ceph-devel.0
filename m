From: Gregory Farnum <greg@inktank.com>
Subject: Re: Rados gateway init timeout with cache
Date: Tue, 8 Jan 2013 13:34:35 -0800
Message-ID: <CAPYLRziC7iGq+R9v7tX8zNqj0ikx59Oe9KvzW-f6OQP5vohY5g@mail.gmail.com>
References: <367CC0B0FC02EE47BF7482398BD623C54E0E3624@DB3PRD0311MB416.eurprd03.prod.outlook.com>
	<367CC0B0FC02EE47BF7482398BD623C54E0E3701@DB3PRD0311MB416.eurprd03.prod.outlook.com>
	<CAPYLRzhwWYA2_DZYgtRhKKEvATNY_4ATY1KwrV-LERocxAwjhQ@mail.gmail.com>
	<367CC0B0FC02EE47BF7482398BD623C54E0E3AA2@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:64315 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab3AHVeg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 16:34:36 -0500
Received: by mail-qa0-f44.google.com with SMTP id z4so143919qan.17
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 13:34:35 -0800 (PST)
In-Reply-To: <367CC0B0FC02EE47BF7482398BD623C54E0E3AA2@DB3PRD0311MB416.eurprd03.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann ROBIN <yann.robin@youscribe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>

On Tue, Jan 8, 2013 at 1:11 PM, Yann ROBIN <yann.robin@youscribe.com> w=
rote:
> We lost data in notify and gc. What bother me is that the rados gatew=
ay can start if we desactivate the cache.
> I think the availability of the cache objects shouldn't take down the=
 rados gateway. The option should be more a "I want the cache if availa=
ble".

But what if some of the instances can access the objects and others
can't? Then you've got daemons caching data and the others aren't
notifying them. This pretty much needs to be a manual switch, as far
as I can imagine it working. Unless somebody else has ideas on
improving it?
-Greg


>
> -----Message d'origine-----
> De : Gregory Farnum [mailto:greg@inktank.com]
> Envoy=E9 : mardi 8 janvier 2013 18:03
> =C0 : Yann ROBIN
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: Rados gateway init timeout with cache
>
> To clarify, you lost the data on half of your OSDs? And it sounds lik=
e they weren't in separate CRUSH failure domains?
>
> Given that, yep, you've lost some data. :(
>
> On Tue, Jan 8, 2013 at 5:41 AM, Yann ROBIN <yann.robin@youscribe.com>=
 wrote:
>> Notify and gc objects where unfound, we marked them as lost and now =
the rados start.
>> But this means that if some notify object are not fully available, t=
he radosgateway stop responding.
>
> Yes, that's the case. I'm not sure there's a way around it that makes=
 much sense and satisfies the necessary guarantees, though.
> -Greg
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Yann ROBIN
>> Sent: mardi 8 janvier 2013 12:13
>> To: ceph-devel@vger.kernel.org
>> Subject: Rados gateway init timeout with cache
>>
>> Hi,
>>
>> We recently experienced issue with the backplane of our server, resu=
lting in loosing half of our osd.
>> During that period the rados gateway failed initializing (timeout).
>> We found that the gateway was hanging in the init_watch function.
>>
>> We recreate our OSDs and we still have this issue, but pg are not al=
l in an active+clean state :
>>    health HEALTH_WARN 1 pgs degraded; 1 pgs recovering; 2 pgs recove=
ry_wait; 3 pgs stuck unclean; recovery 7/10140464 degraded (0.000%); 3/=
5070232 unfound (0.000%); noout flag(s) set
>>    monmap e2: 3 mons at {ceph-mon-1=3D172.20.1.13:6789/0,ceph-mon-2=3D=
172.20.2.13:6789/0,ceph-mon-3=3D172.17.9.20:6789/0}, election epoch 256=
, quorum 0,1,2 ceph-mon-1,ceph-mon-2,ceph-mon-3
>>    osdmap e4439: 6 osds: 6 up, 6 in
>>     pgmap v2531184: 11024 pgs: 11019 active+clean, 2 active+recovery=
_wait, 1 active+recovering+degraded+remapped, 2 active+clean+scrubbing+=
deep; 1291 GB data, 2612 GB used, 19645 GB / 22257 GB avail; 7/10140464=
 degraded (0.000%); 3/5070232 unfound (0.000%)
>>    mdsmap e1: 0/0/1 up
>>
>> Should we open an ticket for this init issue with rados gateway ?
>> Version is 0.56.1 upgraded from 0.55.
>>
>> --
>> Yann ROBIN
>> YouScribe
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
