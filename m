From: "Dave (Bob)" <dave@bob-the-boat.me.uk>
Subject: Re: Mourning the demise of mkcephfs
Date: Tue, 12 Nov 2013 12:23:22 +0000
Message-ID: <52821DBA.6050702@bob-the-boat.me.uk>
References: <5281192D.4090707@bob-the-boat.me.uk> <5281D734.3060807@42on.com> <CAM9_UU-O0FTJyGdNqOGevKUYyU5B7rOavBajSR_j_L5OvVwD0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx01.ip.uk.com ([81.2.115.98]:45819 "EHLO i01.ip.uk.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751868Ab3KLMYb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Nov 2013 07:24:31 -0500
In-Reply-To: <CAM9_UU-O0FTJyGdNqOGevKUYyU5B7rOavBajSR_j_L5OvVwD0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ketor D <d.ketor@gmail.com>, Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 12/11/2013 07:41, Ketor D wrote:
> Hi Bob:
>       mkcephfs is still usable in 0.72 with a little path.We are still
> using mkcephfs on 0.72 because ceph-deploy is not good enough.
>
> You need to patch mkcephfs.in and init-ceph.in to do this.
>
> The patch of mkcephfs.in is you need to modify three symbols:
>     BINDIR=/usr/bin
>     LIBDIR=/usr/lib64/ceph
>     ETCDIR=/etc/ceph
> to the real path in your system.
>
> The patch of init-ceph.in is here:
> Signed-off-by: Ketor D <d.ketor@gmail.com>
> ---
> diff --git "a/src/init-ceph.in" "b/src/init-ceph.in"
> index 7399abb..cf2eaa6 100644
> --- "a/src/init-ceph.in"
> +++ "b/src/init-ceph.in"
> @@ -331,7 +331,8 @@ for name in $what; do
>   -- \
>   $id \
>   ${osd_weight:-${defaultweight:-1}} \
> - $osd_location"
> + $osd_location \
> + || :"
>   fi
>      fi
>
> On Tue, Nov 12, 2013 at 3:22 PM, Wido den Hollander <wido@42on.com> wrote:
>> On 11/11/2013 06:51 PM, Dave (Bob) wrote:
>>> The utility mkcephfs seemed to work, it was very simple to use and
>>> apparently effective.
>>>
>>> It has been deprecated in favour of something called ceph-deploy, which
>>> does not work for me.
>>>
>>> I've ignored the deprecation messages until now, but in going from 70 to
>>> 72 I find that mkcephfs has finally gone.
>>>
>>> I have tried ceph-deploy, and it seems to be tied in to specific
>>> 'distributions' in some way.
>>>
>>> It is unuseable for me at present, because it reports:
>>>
>>> [ceph_deploy][ERROR ] UnsupportedPlatform: Platform is not supported:
>>>
>>>
>>> I therefore need to go back to first principles, but the documentation
>>> seems to have dropped descriptions of driving ceph without smoke and
>>> mirrors.
>>>
>>> The direct approach may be more laborious, but at least it would not
>>> depend on anything except ceph itself.
>>>
>> I myself am not a very big fan of ceph-deploy as well. Most installations I
>> do are done by bootstrapping the monitors and osds manually.
>>
>> I have some homebrew scripts for this, but I mainly use Puppet to make sure
>> all the packages and configuration is present on the nodes and afterwards
>> it's just a matter of adding the OSDs and formatting their disks once.
>>
>> The guide to bootstrapping a monitor:
>> http://eu.ceph.com/docs/master/dev/mon-bootstrap/
>>
>> When the monitor cluster is running you can start generating cephx keys for
>> the OSDs and add them to the cluster:
>> http://eu.ceph.com/docs/master/rados/operations/add-or-rm-osds/
>>
>> I don't know if the docs are 100% correct. I've done this so many times that
>> I do a lot of things without even reading the docs, so there might be a typo
>> in it somewhere. If so, report it so it can be fixed.
>>
>> Where I think that ceph-deploy works for a lot of people I fully understand
>> that some people just want to manually bootstrap a Ceph cluster from
>> scratch.
>>
>> Wido
>>
>>
>>> Maybe I need to step back a version or two, set up my cluster with
>>> mkcephfs, then switch back to the latest to use it.
>>>
>>> I'll search the documentation again.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
Thank you...
David
