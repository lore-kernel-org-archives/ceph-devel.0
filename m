From: kefu chai <tchaikov@gmail.com>
Subject: Re: ceph osd metadata fails if any osd is down
Date: Tue, 25 Oct 2016 20:36:03 +0800
Message-ID: <CAJE9aOO-YRyOtzU45jv4KOFMu+qrsQu4BCWkfu6D9j72dM7xNg@mail.gmail.com>
References: <CAGbviv+8SkMApa8sbc4-ZjvRxRUVM-SZR+dt2u1CvGshVRoinA@mail.gmail.com>
 <CALe9h7dR7oqP73JfBHHFwQYK8TkhRVM2fKtvCi4YoZEk4s4Z8g@mail.gmail.com>
 <CAGbvivKqM8b2aTMAizPRBE-cuCGbcSFSBuFb3w+rwniiz6LBag@mail.gmail.com>
 <alpine.DEB.2.11.1610241716520.14316@piezo.us.to> <CAGbviv+NOCCJb_adcokmVs1oh5xe-RLN=4B5iVWxSDh1BBgwMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:40541 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753881AbcJYMgF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Oct 2016 08:36:05 -0400
Received: by mail-qk0-f175.google.com with SMTP id d23so7250927qke.7
        for <ceph-devel@vger.kernel.org>; Tue, 25 Oct 2016 05:36:04 -0700 (PDT)
In-Reply-To: <CAGbviv+NOCCJb_adcokmVs1oh5xe-RLN=4B5iVWxSDh1BBgwMw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Oct 25, 2016 at 1:25 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Done - http://tracker.ceph.com/issues/17685

it was fixed by
https://github.com/ceph/ceph/commit/c5700ce4b45b3a385fe4c2111da852bea7d86da2.
we should backport it to jewel. updated the tracker ticket.

>
> thanks!
>
> On Mon, Oct 24, 2016 at 1:17 PM, Sage Weil <sweil@redhat.com> wrote:
>> On Mon, 24 Oct 2016, Wyllys Ingersoll wrote:
>>> I think there is still a bug in the "osd metadata" reporting in 10.2.3
>>> - the JSON structure returned is not terminated when the OSD is added
>>> but not running or added to the crush map yet.
>>>
>>> Its an odd condition to get into, but when adding a disk and there is
>>> an issue that causes it to fail to complete the add operation such as
>>> when the permissions in the /var/lib/ceph/osd/osd/XXX are incorrectly
>>> set to root:root instead of ceph:ceph, the metadata output does not
>>> terminate with the final closing bracket "]".
>>>
>>> Here is the end of the (truncated) output from "ceph osd tree" showing
>>> the disk just recently added but without any weight and marked "down".
>>
>> It looks like the code in OSDMonitor.cc is just buggy.. it was some odd
>> error handling that probably doesn't need to be there and then does a goto
>> reply instead of a simple break, so that we skip the close_section().
>>
>> Should be a quick fix and backport.  Do you mind opening a trakcer ticket?
>>
>> Thanks!
>> sage
>>
>>
>>
>>>  -2 130.67999             host ic1ss06
>>>   0   3.62999                 osd.0         up  1.00000          1.00000
>>>   6   3.62999                 osd.6         up  1.00000          1.00000
>>>   7   3.62999                 osd.7         up  1.00000          1.00000
>>>  13   3.62999                 osd.13        up  1.00000          1.00000
>>>  21   3.62999                 osd.21        up  1.00000          1.00000
>>>  27   3.62999                 osd.27        up  1.00000          1.00000
>>>  33   3.62999                 osd.33        up  1.00000          1.00000
>>>  39   3.62999                 osd.39        up  1.00000          1.00000
>>>  46   3.62999                 osd.46        up  1.00000          1.00000
>>>  48   3.62999                 osd.48        up  1.00000          1.00000
>>>  55   3.62999                 osd.55        up  1.00000          1.00000
>>>  60   3.62999                 osd.60        up  1.00000          1.00000
>>>  66   3.62999                 osd.66        up  1.00000          1.00000
>>>  72   3.62999                 osd.72        up  1.00000          1.00000
>>>  75   3.62999                 osd.75        up  1.00000          1.00000
>>>  81   3.62999                 osd.81        up  1.00000          1.00000
>>>  88   3.62999                 osd.88        up  1.00000          1.00000
>>>  97   3.62999                 osd.97        up  1.00000          1.00000
>>>  99   3.62999                 osd.99        up  1.00000          1.00000
>>> 102   3.62999                 osd.102       up  1.00000          1.00000
>>> 110   3.62999                 osd.110       up  1.00000          1.00000
>>> 120   3.62999                 osd.120       up  1.00000          1.00000
>>> 127   3.62999                 osd.127       up  1.00000          1.00000
>>> 129   3.62999                 osd.129       up  1.00000          1.00000
>>> 136   3.62999                 osd.136       up  1.00000          1.00000
>>> 140   3.62999                 osd.140       up  1.00000          1.00000
>>> 147   3.62999                 osd.147       up  1.00000          1.00000
>>> 155   3.62999                 osd.155       up  1.00000          1.00000
>>> 165   3.62999                 osd.165       up  1.00000          1.00000
>>> 166   3.62999                 osd.166       up  1.00000          1.00000
>>> 174   3.62999                 osd.174       up  1.00000          1.00000
>>> 184   3.62999                 osd.184       up  1.00000          1.00000
>>> 190   3.62999                 osd.190       up  1.00000          1.00000
>>> 194   3.62999                 osd.194       up  1.00000          1.00000
>>> 202   3.62999                 osd.202       up  1.00000          1.00000
>>> 209   3.62999                 osd.209       up  1.00000          1.00000
>>> 173         0 osd.173                     down  1.00000          1.00000
>>>
>>>
>>> Now when I run "ceph osd metadata", note that the closing "]" is missing.
>>>
>>> $ ceph osd metadata
>>>
>>> [
>>> ...
>>>         "osd": {
>>>             "id": 213,
>>>             "arch": "x86_64",
>>>             "back_addr": "10.10.21.54:6861\/168468",
>>>             "backend_filestore_dev_node": "unknown",
>>>             "backend_filestore_partition_path": "unknown",
>>>             "ceph_version": "ceph version 10.2.3
>>> (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)",
>>>             "cpu": "Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz",
>>>             "distro": "Ubuntu",
>>>             "distro_codename": "trusty",
>>>             "distro_description": "Ubuntu 14.04.3 LTS",
>>>             "distro_version": "14.04",
>>>             "filestore_backend": "xfs",
>>>             "filestore_f_type": "0x58465342",
>>>             "front_addr": "10.10.20.54:6825\/168468",
>>>             "hb_back_addr": "10.10.21.54:6871\/168468",
>>>             "hb_front_addr": "10.10.20.54:6828\/168468",
>>>             "hostname": "ic1ss04",
>>>             "kernel_description": "#26~14.04.1-Ubuntu SMP Fri Jul 24
>>> 21:16:20 UTC 2015",
>>>             "kernel_version": "3.19.0-25-generic",
>>>             "mem_swap_kb": "15998972",
>>>             "mem_total_kb": "131927464",
>>>             "os": "Linux",
>>>             "osd_data": "\/var\/lib\/ceph\/osd\/ceph-213",
>>>             "osd_journal": "\/var\/lib\/ceph\/osd\/ceph-213\/journal",
>>>             "osd_objectstore": "filestore"
>>>         },
>>>         "osd": {
>>>             "id": 214,
>>>             "arch": "x86_64",
>>>             "back_addr": "10.10.21.55:6877\/177645",
>>>             "backend_filestore_dev_node": "unknown",
>>>             "backend_filestore_partition_path": "unknown",
>>>             "ceph_version": "ceph version 10.2.3
>>> (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)",
>>>             "cpu": "Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz",
>>>             "distro": "Ubuntu",
>>>             "distro_codename": "trusty",
>>>             "distro_description": "Ubuntu 14.04.3 LTS",
>>>             "distro_version": "14.04",
>>>             "filestore_backend": "xfs",
>>>             "filestore_f_type": "0x58465342",
>>>             "front_addr": "10.10.20.55:6844\/177645",
>>>             "hb_back_addr": "10.10.21.55:6879\/177645",
>>>             "hb_front_addr": "10.10.20.55:6848\/177645",
>>>             "hostname": "ic1ss05",
>>>             "kernel_description": "#26~14.04.1-Ubuntu SMP Fri Jul 24
>>> 21:16:20 UTC 2015",
>>>             "kernel_version": "3.19.0-25-generic",
>>>             "mem_swap_kb": "15998972",
>>>             "mem_total_kb": "131927464",
>>>             "os": "Linux",
>>>             "osd_data": "\/var\/lib\/ceph\/osd\/ceph-214",
>>>             "osd_journal": "\/var\/lib\/ceph\/osd\/ceph-214\/journal",
>>>             "osd_objectstore": "filestore"
>>>         }
>>>     }
>>> ^^^^
>>> Missing closing "]"
>>>
>>>
>>> -Wyllys Ingersoll
>>>  Keeper Technology, LLC
>>>
>>>
>>> On Wed, Sep 21, 2016 at 5:12 PM, John Spray <jspray@redhat.com> wrote:
>>> > On Wed, Sep 21, 2016 at 6:29 PM, Wyllys Ingersoll
>>> > <wyllys.ingersoll@keepertech.com> wrote:
>>> >> In 10.2.2 when running "ceph osd metadata" (defaulting to get metdata for
>>> >> "all" OSDs), if even 1 OSD is currently marked "down", the entire command
>>> >> fails and returns an error:
>>> >>
>>> >> $ ceph osd metadata
>>> >> Error ENOENT:
>>> >>
>>> >> - One OSD in the cluster was "down", I removed that OSD and re-ran the
>>> >> command successfully.
>>> >>
>>> >> It seems that the "metadata" command should be able to dump the data for
>>> >> the OSDs that are up and ignore the ones that are down.  Is this a known
>>> >> bug?
>>> >
>>> > Probably fixed by
>>> > https://github.com/ceph/ceph/commit/f5db5a4b0bb52fed544f277c28ab5088d1c3fc79
>>> > which is in 10.2.3
>>> >
>>> > John
>>> >
>>> >>
>>> >> -Wyllys Ingersoll
>>> >>  Keeper Technology, LLC
>>> >> --
>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> >> the body of a message to majordomo@vger.kernel.org
>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
