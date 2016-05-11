From: Tim Serong <tserong@suse.com>
Subject: Re: Introducing libstoragemgmt as a Ceph dependency
Date: Wed, 11 May 2016 16:26:41 +1000
Message-ID: <5732D0A1.7020209@suse.com>
References: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.DEB.2.11.1605031412580.26967@cpach.fuggernut.com>
 <TU4PR84MB00326FE52F4342863273CFA4CC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:34361 "EHLO
	prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbcEKG05 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 11 May 2016 02:26:57 -0400
In-Reply-To: <TU4PR84MB00326FE52F4342863273CFA4CC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joseph" <joseph.t.handzik@hpe.com>, Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "tasleson@redhat.com" <tasleson@redhat.com>, Gris Ge <fge@redhat.com>

On 05/04/2016 04:22 AM, Handzik, Joseph wrote:
> [...]
>> I'm giving all the above for context, but what I really need to know 
>> from the ceph-devel community is: Does anyone have any concerns with 
>> adding libstoragemgmt as a Ceph dependency? It would only work for the 
>> standard Linux flavors and distros (Rhel and Centos, OpenSuse and 
>> SLES, Debian and Ubuntu). The features I'm adding would be no-ops or 
>> disabled for other distros unless someone in the community finds a way 
>> to distribute libstoragemgmt for their operating environment or finds 
>> an adequate replacement for the functionality. It's also worth noting 
>> that I'm completely dependent on the previously mentioned 1.3 release 
>> of libstoragemgmt, which is why I've waited on this for a while (the 
>> blueprint was initially intended for Jewel).
> 
> The current distros upstream currently buidls on are:
> 
>  centos 7
>  ubuntu 16.04
>  ubuntu 14.04
>  debian 8 (jessie)
> 
> Other packages are all down downstream (e.g., opensuse and sles).
> 
> Anyway, is libstoragemgt available for the above?
> 
> [JH] - I'm seeing packages for both 16.04 and 14.04, along with Debian Jessie and Centos7. I think my biggest challenge will be figuring out *exactly* when the 1.3 release of libstoragemgmt is available for all these distros. I don't plan to submit a pull until I can confirm that.

Speaking for a downstream, a quick search shows we've got libstoragemgmt
1.2.x (not 1.3) on the current latest versions of openSUSE and SLES.

Regards,

Tim
-- 
Tim Serong
Senior Clustering Engineer
SUSE
tserong@suse.com
