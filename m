From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: defaults paths
Date: Thu, 5 Apr 2012 10:38:11 +0200
Message-ID: <ACF4E321-F922-41A1-B4EE-A5DD7238F7CA@openminds.be>
References: <Pine.LNX.4.64.1204042320010.28065@cobra.newdream.net> <3177659F-3D4D-45A2-80D3-B344CF604901@openminds.be> <CABYiri_sVOpvbZnJ7rEBsrtDtW+qzo-vSyVLZjEa9gcv8j-+hA@mail.gmail.com> <51BE8674-B8FE-41D0-B284-6D99669CD4CA@openminds.be> <CABYiri9reZTxDTAchovCyuBT6x1OiZYgB72qj=YpzpnMD+WqJw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:51047 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab2DEIiN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 04:38:13 -0400
In-Reply-To: <CABYiri9reZTxDTAchovCyuBT6x1OiZYgB72qj=YpzpnMD+WqJw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

I assume most OSD nodes will normally run a single OSD, so this would not apply to most nodes.

Only in specific cases (where multiple OSDs run on a single node) this would come up, and these specific cases might even require to have the journals split over multiple devices (multiple ssd-disks ...)

In my case, this doesn't really matter, it is up to the provision software to make the needed symlinks/mounts.

Rgds,
Bernard

On 05 Apr 2012, at 09:37, Andrey Korolyov wrote:

> In ceph case, such layout breakage may be necessary in almost all
> installations(except testing), comparing to almost all general-purpose
> server software which need division like that only in very specific
> setups.
> 
> On Thu, Apr 5, 2012 at 11:28 AM, Bernard Grymonpon <bernard@openminds.be> wrote:
>> I feel it's up to the sysadmin to mount / symlink the correct storage devices on the correct paths - ceph should not be concerned that some volumes might need to sit together.
>> 
>> Rgds,
>> Bernard
>> 
>> On 05 Apr 2012, at 09:12, Andrey Korolyov wrote:
>> 
>>> Right, but probably we need journal separation at the directory level
>>> by default, because there is a very small amount of cases when speed
>>> of main storage is sufficient for journal or when resulting speed
>>> decrease is not significant, so journal by default may go into
>>> /var/lib/ceph/osd/journals/$i/journal where osd/journals mounted on
>>> the fast disk.
>>> 
>>> On Thu, Apr 5, 2012 at 10:57 AM, Bernard Grymonpon <bernard@openminds.be> wrote:
>>>> 
>>>> On 05 Apr 2012, at 08:32, Sage Weil wrote:
>>>> 
>>>>> We want to standardize the locations for ceph data directories, configs,
>>>>> etc.  We'd also like to allow a single host to run OSDs that participate
>>>>> in multiple ceph clusters.  We'd like easy to deal with names (i.e., avoid
>>>>> UUIDs if we can).
>>>>> 
>>>>> The metavariables are:
>>>>> cluster = ceph (by default)
>>>>> type = osd, mon, mds
>>>>> id = 1, foo,
>>>>> name = $type.$id = osd.0, mds.a, etc.
>>>>> 
>>>>> The $cluster variable will come from the command line (--cluster foo) or,
>>>>> in the case of a udev hotplug tool or something, matching the uuid on the
>>>>> device with the 'fsid = <uuid>' line in the available config files found
>>>>> in /etc/ceph.
>>>>> 
>>>>> The locations could be:
>>>>> 
>>>>> ceph config file:
>>>>>  /etc/ceph/$cluster.conf     (default is thus ceph.conf)
>>>>> 
>>>>> keyring:
>>>>>  /etc/ceph/$cluster.keyring  (fallback to /etc/ceph/keyring)
>>>>> 
>>>>> osd_data, mon_data:
>>>>>  /var/lib/ceph/$cluster.$name
>>>>>  /var/lib/ceph/$cluster/$name
>>>>>  /var/lib/ceph/data/$cluster.$name
>>>>>  /var/lib/ceph/$type-data/$cluster-$id
>>>>> 
>>>>> TV and I talked about this today, and one thing we want is for items of a
>>>>> given type to live together in separate directory so that we don't have to
>>>>> do any filtering to, say, get all osd data directories.  This suggests the
>>>>> last option (/var/lib/ceph/osd-data/ceph-1,
>>>>> /var/lib/ceph/mon-data/ceph-foo, etc.), but it's kind of fugly.
>>>>> 
>>>>> Another option would be to make it
>>>>> 
>>>>> /var/lib/ceph/$type-data/$id
>>>>> 
>>>>> (with no $cluster) and make users override the default with something that
>>>>> includes $cluster (or $fsid, or whatever) in their $cluster.conf if/when
>>>>> they want multicluster nodes that don't interfere.  Then we'd get
>>>>> /var/lib/ceph/osd-data/1 for non-crazy people, which is pretty easy.
>>>> 
>>>> As a osd consists of data and the journal, it should stay together, with all info for that one osd in one place:
>>>> 
>>>> I would suggest
>>>> 
>>>> /var/lib/ceph/osd/$id/data
>>>> and
>>>> /var/lib/ceph/osd/$id/journal
>>>> 
>>>> ($id could be replaced by $uuid or $name, for which I would prefer $uuid)
>>>> 
>>>> Rgds,
>>>> Bernard
>>>> 
>>>>> 
>>>>> Any other suggestions?  Thoughts?
>>>>> sage
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>> 
>>>> 
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

