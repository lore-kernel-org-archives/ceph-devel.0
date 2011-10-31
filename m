From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [RFC PATCH v3 3/4] qemu: pass virConnectPtr into Domain{Attach,
 Detach}*
Date: Mon, 31 Oct 2011 13:14:54 -0600
Message-ID: <4EAEF3AE.1080400@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>	<4e26cbcba8e3c97941311abbc172b894626b8f96.1319072460.git.josh.durgin@dreamhost.com> <20111027083324.GC20878@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933236Ab1JaTPB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 31 Oct 2011 15:15:01 -0400
In-Reply-To: <20111027083324.GC20878@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Josh Durgin <josh.durgin@dreamhost.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org

On 10/27/2011 02:33 AM, Daniel P. Berrange wrote:
> On Thu, Oct 20, 2011 at 11:01:26AM -0700, Josh Durgin wrote:
>> From: Sage Weil<sage@newdream.net>
>>
>> The qemu RBD driver needs access to the conn in order to get the secret
>> needed for connecting to the ceph cluster.
>>
>> Signed-off-by: Sage Weil<sage@newdream.net>
>> ---
>>   src/qemu/qemu_command.c |    5 +++--
>>   src/qemu/qemu_command.h |    3 ++-
>>   src/qemu/qemu_driver.c  |   17 ++++++++---------
>>   src/qemu/qemu_hotplug.c |   15 +++++++++------
>>   src/qemu/qemu_hotplug.h |    9 ++++++---
>>   5 files changed, 28 insertions(+), 21 deletions(-)
>
> Trivial, ACK

Now pushed.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
