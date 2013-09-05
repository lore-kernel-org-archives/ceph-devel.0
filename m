From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Add Metavariable $imagename
Date: Thu, 05 Sep 2013 11:32:18 -0700
Message-ID: <5228CE32.2040300@inktank.com>
References: <522747D0.6050906@cloudapt.com> <52274CA1.2040801@inktank.com> <522755F1.2000406@cloudapt.com> <alpine.DEB.2.00.1309040919200.1073@cobra.newdream.net> <52282958.2050003@inktank.com> <alpine.DEB.2.00.1309050755450.11518@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:48813 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3IESee (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 14:34:34 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so2278252pac.17
        for <ceph-devel@vger.kernel.org>; Thu, 05 Sep 2013 11:34:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309050755450.11518@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mike Dawson <mike.dawson@cloudapt.com>, Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 09/05/2013 07:59 AM, Sage Weil wrote:
> On Wed, 4 Sep 2013, Josh Durgin wrote:
>> On 09/04/2013 09:22 AM, Sage Weil wrote:
>>> Hi Mike,
>>>
>>> On Wed, 4 Sep 2013, Mike Dawson wrote:
>>>> Thanks for the feature request Mark!
>>>>
>>>> To illustrate where my understanding ends, here is a patch to stub in this
>>>> functionality:
>>>>
>>>>   From 137ebc2d5326ca710a5e99e2899fd851b02c10f7 Mon Sep 17 00:00:00 2001
>>>> From: Mike Dawson <mdawson@gammacode.com>
>>>> Date: Wed, 4 Sep 2013 11:39:05 -0400
>>>> Subject: [PATCH] Update config.cc
>>>>
>>>> ---
>>>>    src/common/config.cc | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/src/common/config.cc b/src/common/config.cc
>>>> index 5c64f4e..89ac0ee 100644
>>>> --- a/src/common/config.cc
>>>> +++ b/src/common/config.cc
>>>> @@ -929,7 +929,7 @@ int md_config_t::set_val_raw(const char *val, const
>>>> config_option *opt)
>>>>    }
>>>>
>>>>    static const char *CONF_METAVARIABLES[] =
>>>> -  { "cluster", "type", "name", "host", "num", "id", "pid" };
>>>> +  { "cluster", "type", "name", "host", "num", "id", "pid", "image-name"
>>>> };
>>>>    static const int NUM_CONF_METAVARIABLES =
>>>>          (sizeof(CONF_METAVARIABLES) / sizeof(CONF_METAVARIABLES[0]));
>>>>
>>>> @@ -1007,6 +1007,8 @@ bool md_config_t::expand_meta(std::string &origval)
>>>> const
>>>>    	  out += name.get_id().c_str();
>>>>    	else if (var == "pid")
>>>>    	  out += stringify(getpid());
>>>> +	else if (var == "image-name")
>>>> +	  out += "TBD"
>>>>    	else
>>>>    	  assert(0); // unreachable
>>>>    	found_meta = true;
>>>> --
>>>> 1.8.4
>>>>
>>>>
>>>> Obviously, the I'm stuck at "TBD". I'll finish it if someone could point
>>>> me in
>>>> the right direction.
>>>
>>> The challenge here is that the image name is currently parsed by things
>>> like rbd.cc or not at all.  And more significantly, a single librbd
>>> instance can map any number of images, but the config context has only one
>>> 'image-name' slot and log.
>>
>> If these were set in librbd, which knows the image name, it would need
>> to delay opening or reopen the files in the new location, since they're
>> initially created when rados_connect() calls common_init_finish(). This
>> happens before librbd gets involved, so the image name isn't available
>> yet.
>>
>>> An alternative approach would be to stick some other unique identification
>>> of the librbd 'instance'.  It would be gibberish but would give you
>>> different instances of the asok file (and/or logs).
>>
>> This would be simplest (it could be done in librados with the unique
>> gibberish determined during rados_connect(), perhaps using the nonce
>> already generated there). This would work with qemu since qemu creates
>> a new rados_cluster_t for each rbd image. I'd rather avoid the gibberish
>> aspect though.
>>
>>> Or, since qemu is the one creating one librbd instance per mapped image,
>>> it could explicitly set the log file and admin socket to something
>>> appropriate.  I think that in general having these enabled by default is a
>>> good thing (especially the admin socket).
>>
>> I think this is a good place to replace rbd-specific metavariables - in
>> things like rbd.cc and qemu that use librbd. This can be done via
>> rados_conf_get() and rados_conf_set() on log_file and admin_socket
>> before calling rados_connect().
>>
>> To avoid duplication, it might be best to provide a librbd method that
>> does this. It could also include any new settings that would need
>> metavariable expansion in the future.
>>
>> Something like:
>>
>> void rbd_expand_config_vars(rados_t cluster,
>>                              const char *pool,
>>                              const char *namespace,
>>                              const char *image,
>>                              const char *snapshot)
>>
>> This would expand $pool, $namespace, $image, and $snapshot via
>> rados_conf_get() and rados_conf_set() on log_file, admin_socket,
>> and others in the future (e.g. persistent cache path).
>
> What about something more generic:
>
> void rados_conf_add_meta(rados_t cluster,
> 	const char *var,
> 	const char *value);
>
> and call it 4 times?  That will things much prettier when we add the 5th
> one.
>
> Is it possible that even with /var/log/ceph/rbd.$pool.$ns.$image.$snap.log
> we'd need some extra gibberish for uniqueness?

You might want $pid in there too, but I don't think having the same
snapshot of the same image used by the same process would be very
common. If someone really needs that for some reason, they can always
explicitly set the paths for the duplicate mappings.

>> One downside to this is that it wouldn't affect config options
>> that are redefined via admin socket commands. This could probably
>> be worked around, but I don't think it's a big enough issue to
>> warrant the extra complexity. Admin socket users can specify a
>> fully-expanded path easily enough.
>
> The method above could register the metavar internally and reapply the
> expansion as appropriate later... then we'd have a

That's a good point. We might still want the librbd function 
(implemented with these new librados functions) so librbd users can
set common metavariables easily.

> void rados_conf_remove_meta(rados_t cluster, const char *var);
>
> for completeness?

When do you see this being used? Unless you're reopening log files as
well, it's not going to have any effect after rados_connect().

> sage
>
>
>
>>
>> Josh
>>
>>>> On 9/4/2013 11:07 AM, Mark Nelson wrote:
>>>>> On 09/04/2013 09:46 AM, Mike Dawson wrote:
>>>>>> There are currently a few metavariables available for use in
>>>>>> ceph.conf:
>>>>>> http://ceph.com/docs/master/rados/configuration/ceph-conf/#metavariables
>>>>>>
>>>>>> In addition to those listed in that document, $pid was added in
>>>>>> Bobtail.
>>>>>> That allows me to get RBD admin sockets for libvirt/qemu guests by
>>>>>> specifying
>>>>>>
>>>>>> [client]
>>>>>>        admin socket = /var/run/ceph/rbd-$pid.asok
>>>>>>
>>>>>> in /etc/ceph/ceph.conf. That works well for VMs with a single volume,
>>>>>> but it does not work for VMs with multiple volumes. With multiple
>>>>>> volumes, the admin only lists data on the last volume specified,
>>>>>> leaving
>>>>>> me unable to monitor stats on any volumes other than the last.
>>>>>>
>>>>>> I imagine you could specify a unique admin socket for each volume on
>>>>>> the
>>>>>> command-line that libvirt uses to spawn qemu, but that seems like a
>>>>>> pain.
>>>>>>
>>>>>> Is it possible instead to add a metavariable that would expand to the
>>>>>> image name? This way, my ceph.conf would look like
>>>>>>
>>>>>>
>>>>>> [client]
>>>>>>        admin socket = /var/run/ceph/$imagename.asok
>>>>>>
>>>>>> and I would end up with admin sockets like:
>>>>>>
>>>>>> /var/run/ceph/rbd-volume-0025b693-6230-443e-ad6a-3aa43efdd648.asok
>>>>>> /var/run/ceph/rbd-volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6.asok
>>>>>>
>>>>>> # rbd -p volumes ls
>>>>>> volume-0025b693-6230-443e-ad6a-3aa43efdd648
>>>>>> volume-009228f3-b8d7-4f3c-8458-0cdbd4809dc6
>>>>>>
>>>>>> I'd be happy to provide a patch if someone could give me sufficient
>>>>>> guidance on how/where to add this functionality.
>>>>>>
>>>>>
>>>>> Created a feature request in the tracker for this:
>>>>>
>>>>> http://tracker.ceph.com/issues/6228
>>>>>
>>>>> Mark

