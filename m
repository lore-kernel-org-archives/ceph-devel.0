From: Andreas Bluemle <andreas.bluemle@itxperts.de>
Subject: Re: FileStore performance: coalescing operations
Date: Thu, 19 Mar 2015 15:59:02 +0100
Message-ID: <20150319155902.70551366@doppio>
References: <20150226152807.5b71a93c@doppio>
	<alpine.DEB.2.00.1503031641550.25972@cobra.newdream.net>
	<alpine.DEB.2.00.1503041607590.25972@cobra.newdream.net>
	<CACJqLyZg--fAhanqwrqvbwUDDxgDPci1ughHU_uvWv1gcc75qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.itxperts.de ([212.202.108.166]:20599 "EHLO
	mail.itxperts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbbCSO7K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 10:59:10 -0400
In-Reply-To: <CACJqLyZg--fAhanqwrqvbwUDDxgDPci1ughHU_uvWv1gcc75qQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

as discussed yesterday during the performance meeting,
I have integratged pull reuest 3878 into v0.93 source code
and re-tested: I can confirm that the changes show a significant
benefit in the CPU consumption of the ceph-osd daemon for a
given workload: the reduction in CPU cosumption for the FileStore
workers is 22% and 10% for the overall CPU consumption of the
ceph-osd daemon.


Regards

Andreas Bluemle

On Thu, 5 Mar 2015 15:04:41 +0800
Haomai Wang <haomaiwang@gmail.com> wrote:

> I think the performance improvement can be refer to
> https://github.com/ceph/ceph/pull/2972 which I did a simple benchmark
> comparison.
> 
> This coalescing should get a lighter improvement but I think obviously
> it should be better.
> 
> On Thu, Mar 5, 2015 at 8:10 AM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 3 Mar 2015, Sage Weil wrote:
> >> I think we should try to avoid the dups in the first place in the
> >> upper layers before resorting to deduping in the FileStore.
> >
> > I took a stab at this:
> >
> >         https://github.com/ceph/ceph/pull/3878
> >
> > Here's what the txns look like now:
> >
> > {
> >     "ops": [
> >         {
> >             "op_num": 0,
> >             "op_name": "omap_setkeys",
> >             "collection": "0.2_head",
> >             "oid": "2\/\/head\/\/0",
> >             "attr_lens": {
> >                 "0000000005.00000000000000000002": 178,
> >                 "_epoch": 4,
> >                 "_info": 729,
> >                 "can_rollback_to": 12,
> >                 "rollback_info_trimmed_to": 12
> >             }
> >         },
> >         {
> >             "op_num": 1,
> >             "op_name": "write",
> >             "collection": "0.2_head",
> >             "oid":
> > "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0",
> > "length": 123, "offset": 0,
> >             "bufferlist length": 123
> >         },
> >         {
> >             "op_num": 2,
> >             "op_name": "setattr",
> >             "collection": "0.2_head",
> >             "oid":
> > "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0", "name":
> > "_", "length": 269
> >         },
> >         {
> >             "op_num": 3,
> >             "op_name": "setattr",
> >             "collection": "0.2_head",
> >             "oid":
> > "8b08fa52\/benchmark_data_maetl_15609_object5\/head\/\/0", "name":
> > "snapset", "length": 31
> >         }
> >     ]
> > }
> >
> > Care to give that a spin and see if it give syou a similar (or
> > better) improvement?
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 



-- 
Andreas Bluemle                     mailto:Andreas.Bluemle@itxperts.de
ITXperts GmbH                       http://www.itxperts.de
Balanstrasse 73, Geb. 08            Phone: (+49) 89 89044917
D-81541 Muenchen (Germany)          Fax:   (+49) 89 89044910

Company details: http://www.itxperts.de/imprint.htm
