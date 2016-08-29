From: Alex Litvak <alexander.v.litvak@gmail.com>
Subject: Re: Ceph 0.94.8 Hammer released
Date: Mon, 29 Aug 2016 11:15:54 -0500
Message-ID: <186c5ccb-99cc-311d-7876-befa61975c3d@gmail.com>
References: <alpine.DEB.2.11.1608262128480.27294@piezo.us.to>
 <robbat2-20160826T225027-679783010Z@orbis-terrarum.net>
 <CAC-Np1yQN3C0kojOKqDUQL9RSscEGTtCdMjjFF4b6d4pNFsyug@mail.gmail.com>
 <CAC-Np1w34ydt1W1ivPOQLWhmgVNsEsnBo7PkZUZVCwOC6fsv5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [195.159.176.226] ([195.159.176.226]:41597 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbcH2QUL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 12:20:11 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
        id 1bePI6-00088U-0p
        for ceph-devel@vger.kernel.org; Mon, 29 Aug 2016 18:20:06 +0200
In-Reply-To: <CAC-Np1w34ydt1W1ivPOQLWhmgVNsEsnBo7PkZUZVCwOC6fsv5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

No binaries are pushed to EL6.  I need them to be there, please ...

On 08/29/2016 09:29 AM, Alfredo Deza wrote:
> On Mon, Aug 29, 2016 at 8:00 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Fri, Aug 26, 2016 at 6:52 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
>>> On Fri, Aug 26, 2016 at 09:31:45PM +0000, Sage Weil wrote:
>>>> * For packages, see http://ceph.com/docs/master/install/get-packages
>>> I don't see any .8 packages for Debian/Ubuntu yet in the older path:
>>> https://download.ceph.com/debian-hammer/pool/main/c/ceph/
>>>
>>> And the flavors variant path:
>>> https://download.ceph.com/debian-hammer/flavors/default/pool/main/c/ceph/
>>> does not contain Hammer builds for Precise yet.
>>
>> The "flavors variant" was introduced with recent changes to support
>> the unified CI build system. So packages got built, signed, and
>> published
>> but to the wrong place.
>>
>> Those have been removed and should be re-published soon. Thanks for catching it!
>
> The binaries are now pushed to the right location. Let me know if you
> see any issues.
>
>
>>
>>
>>>
>>> --
>>> Robin Hugh Johnson
>>> Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
>>> E-Mail   : robbat2@gentoo.org
>>> GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
>>> GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


