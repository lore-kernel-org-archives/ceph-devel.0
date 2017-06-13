From: "Mahalingam, Ganesh" <ganesh.mahalingam@intel.com>
Subject: RE: Ceph ISA-L git submodule
Date: Tue, 13 Jun 2017 17:03:09 +0000
Message-ID: <B209D98D8385BE41BC4DE002C072AEBE859F760F@fmsmsx118.amr.corp.intel.com>
References: <B209D98D8385BE41BC4DE002C072AEBE859F7544@fmsmsx118.amr.corp.intel.com>
 <9e3edca1-efbd-a1dc-0809-da781d045f26@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28020 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751802AbdFMREH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 13 Jun 2017 13:04:07 -0400
In-Reply-To: <9e3edca1-efbd-a1dc-0809-da781d045f26@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Gohad, Tushar" <tushar.gohad@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Loic Dachary
> Sent: Tuesday, June 13, 2017 8:52 AM
> To: Mahalingam, Ganesh <ganesh.mahalingam@intel.com>
> Cc: Gohad, Tushar <tushar.gohad@intel.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: Re: Ceph ISA-L git submodule
> 
> [cc'ing ceph-devel]
> 
> Hi !
> 
> On 06/13/2017 05:25 PM, Mahalingam, Ganesh wrote:
> > Hi Loic,
> > Apologies for the duplicate communication. Just thought leaving an
> > email would be better compared to trusting the persistence of IRC. :)
> >
> > Was wondering if you could shed some light on how the community handles
> submodule updates? Does the maintainer get the latest from the upstream
> project and then a PR will just change the SHA reference or do we do a PR to
> the submodule as well?
> 
> Yes, it's basically how it is done.
[Mahalingam, Ganesh] Thanks Loic. if I understand this as the maintainer updated the ceph copy, might I put in a request to update the ceph fork of isa-l? 
> 
> > We wanted to update the ISA-L sources from v2.16 to v2.18 and hence the
> questions.
> 
> The automated make check will use the new submodule to verify it is able to
> decode/encode shards.
[Mahalingam, Ganesh] Awesome. Thanks for the info.
> 
> Cheers
> 
> --
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
