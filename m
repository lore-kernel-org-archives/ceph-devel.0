From: Tim Serong <tserong@suse.com>
Subject: Re: For calamari <= 1.3.x, ceph.client.admin.keyring on all nodes, or
 just mons?
Date: Mon, 23 May 2016 19:31:26 +1000
Message-ID: <5742CDEE.4090603@suse.com>
References: <574263AE.3010401@suse.com>
 <CALe9h7f3b+Sj8bjEyH6op96yzT_Qtfyzxcg=g4Tt++exWSw88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:45550 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbcEWJbg (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 23 May 2016 05:31:36 -0400
In-Reply-To: <CALe9h7f3b+Sj8bjEyH6op96yzT_Qtfyzxcg=g4Tt++exWSw88Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/23/2016 07:18 PM, John Spray wrote:
> On Mon, May 23, 2016 at 2:58 AM, Tim Serong <tserong@suse.com> wrote:
>> Hi All,
>>
>> Quick question: for Calamari <= 1.3.x, the ceph salt module that does
>> cluster heartbeats and whatnot needs
>> /etc/ceph/ceph.client.admin.keyring.  Does that need to exist on all
>> cluster nodes, or only on the MONs?
> 
> Unless it changed since my days with the code, it should only be
> needed on the mon.  See get_heartbeats(), where the cluster_heartbeat
> part only acts if mon_sockets was populated.

Yep, looks like.  Thanks for that.

Cheers,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
