From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: newstore direction
Date: Wed, 21 Oct 2015 21:16:50 -0400
Message-ID: <56283902.4020006@redhat.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com>
 <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
 <562775DD.8050304@redhat.com>
 <7334B4281E425749B85E08CF7EC6F8534383E481@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbbJVBQx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Oct 2015 21:16:53 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F8534383E481@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/21/2015 08:53 PM, Allen Samuels wrote:
> Fixing the bug doesn't take a long time. Getting it deployed is where the delay is. Many companies standardize on a particular release of a particular distro. Getting them to switch to a new release -- even a "bug fix" point release -- is a major undertaking that often is a complete roadblock. Just my experience. YMMV.
>

Customers do control the pace that they upgrade their machines, but we put out 
fixes on a very regular pace.  A lot of customers will get fixes without having 
to qualify a full new release (i.e., fixes come out between major and minor 
releases are easy).

If someone is deploying a critical server for storage, then it falls back on the 
storage software team to help guide them and encourage them to update when 
needed (and no promises of success, but people move if the win is big. If it is 
not, they can wait).

ric

