From: John Spray <jspray@redhat.com>
Subject: Re: make error while building ceph
Date: Fri, 4 Mar 2016 10:53:36 +0000
Message-ID: <CALe9h7e0to34vtDV1xLjSOAT+OXAjTrqsjzsxq5uCakpEM-7eg@mail.gmail.com>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
 <56D2D089.7090109@dachary.org> <CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
 <56D2D55C.7060603@dachary.org> <CAPpuMWyePM_TvmO1MHFRF=jQMw5KRqyy4FA3+QRU2pAq97UwSw@mail.gmail.com>
 <56D460AD.9070806@dachary.org> <CAPpuMWxo-qSeMyiv2eMNhbM-5=dp-+eQOxqvH_yZUNCenfDQUg@mail.gmail.com>
 <56D59D02.1050808@redhat.com> <CAPpuMWzZHMLSTRuWcvwbQLQ9hSj2+BufYLB5BTAys+0_KDHh4g@mail.gmail.com>
 <56D5F871.2040901@suse.cz> <CAPpuMWw6dO9SMwKciX-_GmnzbzU-jUh2RsjH1gjpWd_YvdikKA@mail.gmail.com>
 <56D6670F.9070803@redhat.com> <CAANLjFpFOJcHjtH+_Lb_mefZHbqnY-0n_da0_r1EiZ-iCi7n3g@mail.gmail.com>
 <CAPpuMWzdjoazHYMxUp2bSW18qpVZ9Rb1xgNeVZhzH9qtbW6DJA@mail.gmail.com> <CAPpuMWyH1ZHX9LptfHvd5xirGqD_BQkYU2jtL0ZLXBo0ycG6pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34431 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbcCDKx6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2016 05:53:58 -0500
Received: by mail-lb0-f175.google.com with SMTP id cf7so40293239lbb.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2016 02:53:57 -0800 (PST)
In-Reply-To: <CAPpuMWyH1ZHX9LptfHvd5xirGqD_BQkYU2jtL0ZLXBo0ycG6pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jai <jai_97@rediffmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Mar 4, 2016 at 9:58 AM, Jai <jai_97@rediffmail.com> wrote:
> after build and install, these commands are supposed to work - right ?
> I dont see a rados.py in the tree. I tried copying rados.pyx and .pxd
> to /usr/local/lib/python2.7/site-packages, but that didn't help. There
> was a bug reported on this a while ago, but don't know if it was
> fixed.
>
>
> ceph -v
> Traceback (most recent call last):
>   File "/usr/local/bin/ceph", line 108, in <module>
>     import rados
> ImportError: No module named rados
> [jai@localhost ceph]$ lsmod |grep ceph  --> nothing

The module you're looking for is built into a rados.so file, in
src/pybind/build/ (this is a recent change in master)

It is definitely getting installed in built RPM/deb packages, so
possibly something is going wrong here in the "make install" step in
your environment.  Make install should be running a "python setup.py
build install" type command line (see pybind/rados/Makefile.am
install-exec section): look for that in the output of make install and
see where it's putting your rados module.

John

>
> --
> Jai
>
> On Wed, Mar 2, 2016 at 12:10 PM, Jai <jai_97@rediffmail.com> wrote:
>> I guess I was able to build it (finally) with 4G and make -j 2 on the
>> centos 7 VM.
>>
>> ...
>> build succeeded, 2 warnings.
>>
>> --Jai
>>
>> On Wed, Mar 2, 2016 at 9:49 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> I've seen compiling OSD take 4 GB of RAM, so you would be pretty tight
>>> on RAM, you would probably have to swap at that point. Most of the
>>> rest seems to be a lot less. You could try running 'make -j 4' and
>>> when it fails, run just straight 'make'.
>>> -----BEGIN PGP SIGNATURE-----
>>> Version: Mailvelope v1.3.6
>>> Comment: https://www.mailvelope.com
>>>
>>> wsFcBAEBCAAQBQJW1mnnCRDmVDuy+mK58QAA36oP/j2CQxSedg4HeQokJOQO
>>> nd6SPXuWAeHP4CGMmDTqbuDlKxQA5XRY9LhkmplidMvSVUpEq0gtfU4xj2TH
>>> Qsfb0QqCvZUfMWIFr+TFoFlFP+TS13+ckPca15zuSrD8hggskdB1b61LJCYr
>>> 5688RFG2n5wZdDID70h4wrFsrbiSkaa19VyF6j59W+CbiByy8soPCWf7UA83
>>> yVcRdtMrSMmBypJTO87SuOaYzZnV/6S+MZeL6IOSNs41d3yfOR7S0XjQj4D4
>>> ydCP/O5PEcU6xo8G4mvmqunjbMvzOS+aDLX7ZTtrN1d2JySDDRoNpZ3u5SzN
>>> /Z5/MdLa1D4POmj5d5s1/GSmNXryb3T2cwFqjHGRD2/9ptqa1uMCxlJeAt6A
>>> yOqNujQHavcOS3v30C/iErvHbHyy5zpdgJ3cIHmbXGcYE9gkPMGbQGEDIquk
>>> 8oyxa9hQwY8O9Vml2Cyp8S8ZwtqfeftCF+79Ve/rzvQj8M1Q+UPXiWy4o6Vm
>>> fNoRpjBB1HxXNKiXzIjHHna3T4ZnQCxohAdRzF9oYqWjeCvZdMw1GfBdhNam
>>> v7wA0tAItjngxWCBLu3TEDV8uwlnrnXb9TJuvyRVIR3XZxDQ4DRgFbeWqDco
>>> nZXklY55Aa9PMOwrqckPhiQmb6pw1+ga4iQMgBE2OdRr390QpIVoZR20Cxty
>>> dTXS
>>> =zt+g
>>> -----END PGP SIGNATURE-----
>>> ----------------
>>> Robert LeBlanc
>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>>
>>>
>>> On Tue, Mar 1, 2016 at 9:07 PM, David Zafman <dzafman@redhat.com> wrote:
>>>>
>>>> Jai,
>>>>
>>>> On my build machine with 8GB of RAM a make -j4 works fine.  So I don't see
>>>> why 4GB shouldn't handle a straight make.  YMMV
>>>>
>>>> David
>>>>
>>>>
>>>> On 3/1/16 6:59 PM, Jai wrote:
>>>>>
>>>>> I ve got 8G on my laptop - so I can retry with something less than
>>>>> that for the VM. Ive reinstalled Centos7 and gone back to gcc 4.8.5
>>>>> which is the default on centos 7.
>>>>> cmake - I ve tried it, got errors here too.
>>>>> --
>>>>> Jai
>>>>>
>>>>> On Wed, Mar 2, 2016 at 1:45 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>>>>
>>>>>> On 03/01/2016 03:39 PM, Jai wrote:
>>>>>>>
>>>>>>> I saw one report of a RAM issue.
>>>>>>> I have 2G on the VM - and  it was hung for > half a day.
>>>>>>
>>>>>>
>>>>>> I've found that compiling Ceph requires at least 8GB of RAM - anything
>>>>>> less
>>>>>> is a recipe for failure. I have not tried using cmake, though.
>>>>>>
>>>>>> --
>>>>>> Nathan Cutler
>>>>>> Software Engineer Distributed Storage
>>>>>> SUSE LINUX, s.r.o.
>>>>>> Tel.: +420 284 084 037
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
