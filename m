From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: deb/rpm package purge
Date: Wed, 20 Mar 2013 09:48:42 -0500
Message-ID: <5149CC4A.9030409@inktank.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net> <5148C4EE.5090205@inktank.com> <5148CEC2.2050405@inktank.com> <alpine.DEB.2.00.1303191349360.4850@cobra.newdream.net> <1363732049.12547.22.camel@julia> <alpine.DEB.2.00.1303191528510.4850@cobra.newdream.net> <1363733473.12547.33.camel@julia> <alpine.DEB.2.00.1303191554590.4850@cobra.newdream.net> <1363760969.12547.52.camel@julia> <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55150 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542Ab3CTOso (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 10:48:44 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so2135233iea.12
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 07:48:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303200545140.11428@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Laszlo Boszormenyi (GCS)" <gcs@debian.hu>, Dan Mick <dan.mick@inktank.com>, ceph-devel@vger.kernel.org, james.page@ubuntu.com

On 03/20/2013 07:48 AM, Sage Weil wrote:
> On Wed, 20 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
>> On Tue, 2013-03-19 at 15:59 -0700, Sage Weil wrote:
>>> On Tue, 19 Mar 2013, Laszlo Boszormenyi (GCS) wrote:
>>>> On the other hand, 'dpkg --purge' is to remove everything the package
>>>> has installed and/or generated. This includes debconf answers as well.
>>>> With other words, purge is used to make the system totally clean of the
>>>> package. As such, if the sysadmin install the package again, all debconf
>>>> questions will be asked again and all generated files will be generated
>>>> again from scratch.
>>>
>>> I understand that part, but the policy isn't very clear about files that
>>> are not part of the package but are generated as a result of the package
>>> being installed (i.e., user data).
>>   Forgive me, I just learnt English and my wording may not be that clear
>> for a natural speaker.
>>
>>> As a point of comparison, mysql removes the config files but not
>>> /var/lib/mysql.
>>   As I remember, MySQL asks if /var/lib/mysql/ should be purged or not; I
>> may mix with an other (database related) package.
>>
>>> The question is, is that okay/typical/desireable/recommended/a bad idea?
>>   I can rephrase my words. Purge removes the (binary) package files, its
>> configuration and logs (its generated files). To emphasis, user files
>> are _not_ fall into this category and must remain as-is, _intact_.
>> Some packages writes a console message that 'your files remain at xxx,
>> they were not removed' on purge. Others just leave the dpkg warning
>> "directory not empty so not removed" which means user files may have
>> left there and that may be the reason the directory is not empty.
>>   I'm in a rush, but hopefully will be able to note policy parts in the
>> afternoon (CET).
>
> Thanks, Laszlo, that's exactly what I was after!  Sorry for the confusing
> exchange.  :)
>
> Sounds like in this case, the fix is simply to leave /var/lib/ceph
> untouched.
>
> We'll need to update teuthology ceph.py and nuke to clean up /var/lib/ceph
> (for qa runs), and I think we should add a ceph-deploy 'purgedata' command
> to clean out /var/lib/ceph on a given host.

It's not as important given that it won't outright destroy the cluster, 
but perhaps we should also leave /etc/ceph untouched on purge if a 
ceph.conf file has been placed in it (since that also was not installed 
by the package, but rather by a user?).  I figure we should probably try 
to get it right now.  The message about the directory not being empty 
sounds good.

My thought here is:

- remove anything created by the packages in /var/lib/ceph that has been 
untouched since package installation.
- remove /var/lib/ceph if it has been untouched
- remove /etc/ceph if it has been untouched

Thoughts?

>
> Thanks!
> sage
>

Mark
