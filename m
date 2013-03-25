From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 22/39] mds: handle linkage mismatch during cache rejoin
Date: Mon, 25 Mar 2013 09:14:24 -0700
Message-ID: <CAPYLRzg8smtz=YLkN278iuFjJ_7S5Z=JmFLjONwdQ-Fd9STR-Q@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-23-git-send-email-zheng.z.yan@intel.com>
	<CAPYLRzi5wRLUndEczMbrwjNBTwKwdOvFw=s5bhDNDcncWMxSuQ@mail.gmail.com>
	<514BCA86.7090201@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:56362 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531Ab3CYQO0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 12:14:26 -0400
Received: by mail-qa0-f54.google.com with SMTP id o13so1370709qaj.6
        for <ceph-devel@vger.kernel.org>; Mon, 25 Mar 2013 09:14:25 -0700 (PDT)
In-Reply-To: <514BCA86.7090201@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>, Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 21, 2013 at 8:05 PM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> On 03/22/2013 05:23 AM, Gregory Farnum wrote:
>> On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
>>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>>
>>> For MDS cluster, not all file system namespace operations that impact
>>> multiple MDS use two phase commit. Some operations use dentry link/unlink
>>> message to update replica dentry's linkage after they are committed by
>>> the master MDS. It's possible the master MDS crashes after journaling an
>>> operation, but before sending the dentry link/unlink messages. Later when
>>> the MDS recovers and receives cache rejoin messages from the surviving
>>> MDS, it will find linkage mismatch.
>>
>> I think you're here talking about link/unlink, and the MDS crashing
>> after it's sent out the LogEvent to the OSD but it hasn't actually
>> dispatched the observer slave requests. Is that right? This commit
>> message really confused me; I was trying to figure out which namespace
>> operations were hacking around a proper 2-phase commit by unlinking
>> and relinking inodes into the tree! (The link/unlink code also is
>> doing a 2-phase commit, it just doesn't force a particular order for
>> the journaling, which was previously left unhandled).
>
> I was talking about the cases that use MDCache::send_dentry_{link,unlink}
> to update replica dentry. There are a lot of usage in Server.cc.

Ah, we do this on mknod and openc as well as an explicit client link,
which makes sense. I think I was reading more into your statement than
was actually there.
-Greg
