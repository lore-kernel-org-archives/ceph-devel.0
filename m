From: Michael Grosser <ceph@seetheprogress.net>
Subject: Re: Backups
Date: Sat, 16 Feb 2013 17:53:06 +0100
Message-ID: <CAH0TXZkEsi3j69jede2NvaNMSHCOtArfuhPqK1YAmTLu7MhsAg@mail.gmail.com>
References: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:40071 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab3BPQxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:53:08 -0500
Received: by mail-qe0-f54.google.com with SMTP id 1so1864385qeb.41
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:53:07 -0800 (PST)
In-Reply-To: <CAJH6TXjWNmc15TZKEhyPbJ5HPKcL4EC_YBQsQtOfYJOYuk1S9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hey,

I thought about some ideas, but I didn't really get any response.
You can take a look at some concepts:
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/12061

The easiest is probably to have a backup ceph system and use this to
store backups and then for the different backups:
for cephfs for each fs do a snapshot and upload it to the backup ceph system.
for rgw loop through all containers and loop through all files and
backup them to the backup ceph system.
for rbd snapshot blockdevices and backup them to the backup ceph system.

With this approach you have the ability to have versioned backups if
you use some sort of versioning when you put all monthly ones into
their own pool for example or so.

The downside so is that it really strains the system to make backups
of the whole data and not partially the changed data (I imagine) and
second the bandwidth needed for storing these backups would be for
each backup the whole storage size of the production ceph cluster so
bandwidth saving with only storing changed stuff could be hard.

Just a few hints.

Cheers Michael

On Sat, Feb 16, 2013 at 5:15 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> Hi,
> let's assume a huge ceph clusters, with 300TB full of datas (rgw, rbd
> and the future cephfs)
> How will you manage backups of this cluster?
>
> Will snapshot be enough? For example, one snapshot per day should be
> allow me to revert or restore a single file from the previous day.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
