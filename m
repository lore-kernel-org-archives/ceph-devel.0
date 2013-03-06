From: Neil Levine <neil.levine@inktank.com>
Subject: Re: OpenStack summit : Ceph design session
Date: Wed, 6 Mar 2013 11:27:38 -0800
Message-ID: <CANygib_axAT=3vmG39GNCb0X_1Goycy+P6nF2UQyBcUm9EqbUA@mail.gmail.com>
References: <51289AF2.9010509@dachary.org>
	<512A9F5F.7080706@inktank.com>
	<CANygib_m5h6F7u5ayzSTdZ2Y_8mO414dFXQup2w8NTWQtYWc9w@mail.gmail.com>
	<512B3725.4040602@dachary.org>
	<513319E8.7000105@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:35123 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3CFT1i convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 14:27:38 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so7740784iak.32
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 11:27:38 -0800 (PST)
In-Reply-To: <513319E8.7000105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I think the multi-site RGW stuff is somewhat orthogonal to OpenStack
where as the RBD backups needs to factor in Horizon, Cinder APIs and
where the logic for managing the backups sits.

Ross is looking to get a wiki setup for Ceph blueprints so we can
document the incremental snapshot stuff and then use this as a basis
for creating the OpenStack blueprint.

Who approves the session at ODS and when is this decision made?

Neil

On Sun, Mar 3, 2013 at 1:37 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Neil,
>
> I've updated http://summit.openstack.org/cfp/details/38 with the Geog=
raphic DR related threads
>
>     Geo-replication with RADOS GW http://marc.info/?l=3Dceph-devel&m=3D=
135939566407623&w=3D4
>     Geographic DR for RGW http://marc.info/?l=3Dceph-devel&m=3D136191=
479931880&w=3D4
>
> I'm increasingly interested in figuring out how it fits with OpenStac=
k.
>
> Cheers
>
> On 02/25/2013 11:04 AM, Loic Dachary wrote:
>> Hi Neil,
>>
>> I've added "RBD backups secondary clusters within Openstack" to the =
list of blueprints. Do you have links to mail threads / chat logs relat=
ed to this topic ?
>>
>> I moved the content of the session to an etherpad for collaborative =
editing
>>
>> https://etherpad.openstack.org/roadmap-for-ceph-integration-with-ope=
nstack
>>
>> and it is now linked from
>>
>> http://summit.openstack.org/cfp/details/38
>>
>> Cheers
>>
>> On 02/25/2013 07:12 AM, Neil Levine wrote:
>>> Thanks for taking the lead on this Loic.
>>>
>>> As a blueprint, I'd like to look at RBD backups to secondary cluste=
rs
>>> within Openstack. Nick Barcet and others have mentioned ideas for t=
his
>>> now that Cinder is multi-cluster aware.
>>>
>>> Neil
>>>
>>> On Sun, Feb 24, 2013 at 3:16 PM, Josh Durgin <josh.durgin@inktank.c=
om> wrote:
>>>> On 02/23/2013 02:33 AM, Loic Dachary wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> In anticipation of the next OpenStack summit
>>>>> http://www.openstack.org/summit/portland-2013/, I proposed a sess=
ion to
>>>>> discuss OpenStack and Ceph integration. Our meeting during FOSDEM=
 earlier
>>>>> this month was a great experience although it was planned at the =
last
>>>>> minute. I hope we can organize something even better for the summ=
it.
>>>>>
>>>>> For developers and contributors to both Ceph and OpenStack such a=
s myself,
>>>>> it would be a great opportunity to figure out a sensible roadmap =
for the
>>>>> next six months. I realize this roadmap is already clear for Josh=
 Durgin and
>>>>> other Ceph / OpenStack developers who are passionately invested i=
n both
>>>>> projects for a long time. However I am new to both projects and s=
uch a
>>>>> session would be a precious guide and highly motivating.
>>>>>
>>>>> http://summit.openstack.org/cfp/details/38
>>>>>
>>>>> What do you think ?
>>>>>
>>>>
>>>> Sounds like a great idea!
>>>> Thanks for putting together the session!
>>>>
>>>> Josh
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
