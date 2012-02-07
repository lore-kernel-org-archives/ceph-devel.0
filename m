From: Florian Haas <florian@hastexo.com>
Subject: Re: Nova on RBD Device
Date: Wed, 8 Feb 2012 00:15:38 +0100
Message-ID: <CAPUexz9OwigAdfLEpV_79PvW6f48s0OvXCKY1j9CMUX2Hp8ofg@mail.gmail.com>
References: <CA+jddaPFD5qVmUFVygW-HgWbCCvhM6A+_2BCann7NuZgmwgRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64042 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab2BGXPj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2012 18:15:39 -0500
Received: by qcqw6 with SMTP id w6so4402107qcq.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Feb 2012 15:15:39 -0800 (PST)
In-Reply-To: <CA+jddaPFD5qVmUFVygW-HgWbCCvhM6A+_2BCann7NuZgmwgRJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, Feb 7, 2012 at 8:01 PM, Mandell Degerness
<mandell@pistoncloud.com> wrote:
> Can anyone point me in the right direction for setting up Nova so that
> it allocates disk space on RBD device(s) rather than on local disk as
> defined in the --instances_path flag?
>
> I've already got nova-volume working with RBD.
>
> I suspect that I need to modify _cache_image and _create_image in
> nova/virt/libvirt/connection.py.

Hmmm. Wouldn't that most likely be a question for the openstack list?
http://wiki.openstack.org/MailingLists for details on how to
subscribe, if you haven't already.

Cheers,
Florian

-- 
Need help with High Availability?
http://www.hastexo.com/now
