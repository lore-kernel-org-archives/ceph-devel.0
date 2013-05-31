From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Speed up 'rbd rm'
Date: Fri, 31 May 2013 08:40:50 +0200
Message-ID: <51A845F2.8050001@profihost.ag>
References: <20130529055942.GA3977@onthe.net.au> <51A65523.10107@inktank.com> <20130530022307.GA27809@onthe.net.au> <51A7BB86.3020106@inktank.com> <20130531014049.GA424@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:48273 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab3EaGk5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 02:40:57 -0400
In-Reply-To: <20130531014049.GA424@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Am 31.05.2013 03:40, schrieb Chris Dunlop:
> On Thu, May 30, 2013 at 01:50:14PM -0700, Josh Durgin wrote:
>> On 05/29/2013 07:23 PM, Chris Dunlop wrote:
>>> On Wed, May 29, 2013 at 12:21:07PM -0700, Josh Durgin wrote:
>>>> On 05/28/2013 10:59 PM, Chris Dunlop wrote:
>>>>> I see there's a new commit to speed up an 'rbd rm':
>>>>>
>>>>> http://tracker.ceph.com/projects/ceph/repository/revisions/40956410169709c32a282d9b872cb5f618a48926
>>>>>
>>>>> Is it safe to cherry-pick this commit on top of 0.56.6 (or, if not, v0.61.2) to speed up the remove?
>>>>
>>>> You'll need 537386d906b8c0e395433461dcb03a82eb33f34f as well. It should
>>>> apply cleanly to 0.61.2, and probably 0.56.6 too.

I cherry picked both on top of cuttlefish it works but not very good.
rbd command finishes but rbd image is still in rbd ls and just gets
deleted later. I also saw a variant, where rbd rm outputs errors even
though the image was there but it still got deleted...

Stefan
