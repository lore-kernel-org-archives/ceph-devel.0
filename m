From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: make error while building ceph
Date: Wed, 30 Mar 2016 13:59:28 -0700
Message-ID: <CAB2gnbXVb1EXqmPgmFe8-ro3QrHc3Kq15zcrNHqOifKBBd+bfw@mail.gmail.com>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
	<56D2D089.7090109@dachary.org>
	<CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
	<56D2D55C.7060603@dachary.org>
	<CAPpuMWyePM_TvmO1MHFRF=jQMw5KRqyy4FA3+QRU2pAq97UwSw@mail.gmail.com>
	<56D460AD.9070806@dachary.org>
	<CAPpuMWxo-qSeMyiv2eMNhbM-5=dp-+eQOxqvH_yZUNCenfDQUg@mail.gmail.com>
	<56D59D02.1050808@redhat.com>
	<CAPpuMWzZHMLSTRuWcvwbQLQ9hSj2+BufYLB5BTAys+0_KDHh4g@mail.gmail.com>
	<56D5F871.2040901@suse.cz>
	<CAPpuMWw6dO9SMwKciX-_GmnzbzU-jUh2RsjH1gjpWd_YvdikKA@mail.gmail.com>
	<56D6670F.9070803@redhat.com>
	<CAANLjFpFOJcHjtH+_Lb_mefZHbqnY-0n_da0_r1EiZ-iCi7n3g@mail.gmail.com>
	<CAPpuMWzdjoazHYMxUp2bSW18qpVZ9Rb1xgNeVZhzH9qtbW6DJA@mail.gmail.com>
	<CAPpuMWyH1ZHX9LptfHvd5xirGqD_BQkYU2jtL0ZLXBo0ycG6pQ@mail.gmail.com>
	<CALe9h7e0to34vtDV1xLjSOAT+OXAjTrqsjzsxq5uCakpEM-7eg@mail.gmail.com>
	<CAPpuMWwEaTyQE3nqV5mXiSGr3_wwg_dt1t+jzecd=R+nSjJbBg@mail.gmail.com>
	<CAPpuMWwcE0TQM+tGheWOJcxc+vRK+N36ipUVU1o=22D+Rh2XsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38548 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbcC3U73 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 16:59:29 -0400
Received: by mail-ig0-f178.google.com with SMTP id ui10so43303369igc.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 13:59:29 -0700 (PDT)
In-Reply-To: <CAPpuMWwcE0TQM+tGheWOJcxc+vRK+N36ipUVU1o=22D+Rh2XsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jai <jai_97@rediffmail.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I hit this too in the latest jewel branch running vstart. This is the
patch I used but I'm not sure its the robust fix:

diff --git a/src/ceph.in b/src/ceph.in
index 321dfae..c75f510 100755
--- a/src/ceph.in
+++ b/src/ceph.in
@@ -69,7 +69,7 @@ def respawn_in_path(lib_path, pybind_path, pythonlib_path):
 def get_pythonlib_dir():
     """Returns the name of a distutils build directory"""
     import sysconfig
-    f = "lib.{platform}-{version[0]}.{version[1]}"
+    f = "build/lib.{platform}-{version[0]}.{version[1]}"
     name = f.format(platform=sysconfig.get_platform(),
                     version=sys.version_info)
     return name

On Wed, Mar 9, 2016 at 1:17 AM, Jai <jai_97@rediffmail.com> wrote:
> I synced my tree with the latest to see if it would solve the install
> problem with rados.  install gives me this error now --
>
> zipimport.ZipImportError: bad local file header in
> /usr/lib/python2.7/site-packages/ceph_detect_init-1.0.1-py2.7.egg
> make[4]: *** [ceph-detect-init-install-data] Error 1
>
> The archive appears to be corrupt. This archive is overwritten in the
> install process.
> Anyone seen this ?
> --
> Jai
>
> On Sat, Mar 5, 2016 at 12:14 AM, Jai <jai_97@rediffmail.com> wrote:
>> In pybind/rados, install should run -- python setup.py install, but
>> the make output only shows "build" inside pybind/rbd and pybind/rados.
>> I'll need to figure out what options it should pass into this install
>> command and run it manually. Another thing is to find out why
>> src/Makefile doesn't call  rados-pybind-install-exec
>>
>> ---
>>
>> On Fri, Mar 4, 2016 at 4:23 PM, John Spray <jspray@redhat.com> wrote:
>>> On Fri, Mar 4, 2016 at 9:58 AM, Jai <jai_97@rediffmail.com> wrote:
>>>> after build and install, these commands are supposed to work - right ?
>>>> I dont see a rados.py in the tree. I tried copying rados.pyx and .pxd
>>>> to /usr/local/lib/python2.7/site-packages, but that didn't help. There
>>>> was a bug reported on this a while ago, but don't know if it was
>>>> fixed.
>>>>
>>>>
>>>> ceph -v
>>>> Traceback (most recent call last):
>>>>   File "/usr/local/bin/ceph", line 108, in <module>
>>>>     import rados
>>>> ImportError: No module named rados
>>>> [jai@localhost ceph]$ lsmod |grep ceph  --> nothing
>>>
>>> The module you're looking for is built into a rados.so file, in
>>> src/pybind/build/ (this is a recent change in master)
>>>
>>> It is definitely getting installed in built RPM/deb packages, so
>>> possibly something is going wrong here in the "make install" step in
>>> your environment.  Make install should be running a "python setup.py
>>> build install" type command line (see pybind/rados/Makefile.am
>>> install-exec section): look for that in the output of make install and
>>> see where it's putting your rados module.
>>>
>>> John
>>>
>>>>
>>>> --
>>>> Jai
>>>>
>>>> On Wed, Mar 2, 2016 at 12:10 PM, Jai <jai_97@rediffmail.com> wrote:
>>>>> I guess I was able to build it (finally) with 4G and make -j 2 on the
>>>>> centos 7 VM.
>>>>>
>>>>> ...
>>>>> build succeeded, 2 warnings.
>>>>>
>>>>> --Jai
>>>>>
>>>>> On Wed, Mar 2, 2016 at 9:49 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA256
>>>>>>
>>>>>> I've seen compiling OSD take 4 GB of RAM, so you would be pretty tight
>>>>>> on RAM, you would probably have to swap at that point. Most of the
>>>>>> rest seems to be a lot less. You could try running 'make -j 4' and
>>>>>> when it fails, run just straight 'make'.
>>>>>> -----BEGIN PGP SIGNATURE-----
>>>>>> Version: Mailvelope v1.3.6
>>>>>> Comment: https://www.mailvelope.com
>>>>>>
>>>>>> wsFcBAEBCAAQBQJW1mnnCRDmVDuy+mK58QAA36oP/j2CQxSedg4HeQokJOQO
>>>>>> nd6SPXuWAeHP4CGMmDTqbuDlKxQA5XRY9LhkmplidMvSVUpEq0gtfU4xj2TH
>>>>>> Qsfb0QqCvZUfMWIFr+TFoFlFP+TS13+ckPca15zuSrD8hggskdB1b61LJCYr
>>>>>> 5688RFG2n5wZdDID70h4wrFsrbiSkaa19VyF6j59W+CbiByy8soPCWf7UA83
>>>>>> yVcRdtMrSMmBypJTO87SuOaYzZnV/6S+MZeL6IOSNs41d3yfOR7S0XjQj4D4
>>>>>> ydCP/O5PEcU6xo8G4mvmqunjbMvzOS+aDLX7ZTtrN1d2JySDDRoNpZ3u5SzN
>>>>>> /Z5/MdLa1D4POmj5d5s1/GSmNXryb3T2cwFqjHGRD2/9ptqa1uMCxlJeAt6A
>>>>>> yOqNujQHavcOS3v30C/iErvHbHyy5zpdgJ3cIHmbXGcYE9gkPMGbQGEDIquk
>>>>>> 8oyxa9hQwY8O9Vml2Cyp8S8ZwtqfeftCF+79Ve/rzvQj8M1Q+UPXiWy4o6Vm
>>>>>> fNoRpjBB1HxXNKiXzIjHHna3T4ZnQCxohAdRzF9oYqWjeCvZdMw1GfBdhNam
>>>>>> v7wA0tAItjngxWCBLu3TEDV8uwlnrnXb9TJuvyRVIR3XZxDQ4DRgFbeWqDco
>>>>>> nZXklY55Aa9PMOwrqckPhiQmb6pw1+ga4iQMgBE2OdRr390QpIVoZR20Cxty
>>>>>> dTXS
>>>>>> =zt+g
>>>>>> -----END PGP SIGNATURE-----
>>>>>> ----------------
>>>>>> Robert LeBlanc
>>>>>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>>>>>
>>>>>>
>>>>>> On Tue, Mar 1, 2016 at 9:07 PM, David Zafman <dzafman@redhat.com> wrote:
>>>>>>>
>>>>>>> Jai,
>>>>>>>
>>>>>>> On my build machine with 8GB of RAM a make -j4 works fine.  So I don't see
>>>>>>> why 4GB shouldn't handle a straight make.  YMMV
>>>>>>>
>>>>>>> David
>>>>>>>
>>>>>>>
>>>>>>> On 3/1/16 6:59 PM, Jai wrote:
>>>>>>>>
>>>>>>>> I ve got 8G on my laptop - so I can retry with something less than
>>>>>>>> that for the VM. Ive reinstalled Centos7 and gone back to gcc 4.8.5
>>>>>>>> which is the default on centos 7.
>>>>>>>> cmake - I ve tried it, got errors here too.
>>>>>>>> --
>>>>>>>> Jai
>>>>>>>>
>>>>>>>> On Wed, Mar 2, 2016 at 1:45 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>>>>>>>>
>>>>>>>>> On 03/01/2016 03:39 PM, Jai wrote:
>>>>>>>>>>
>>>>>>>>>> I saw one report of a RAM issue.
>>>>>>>>>> I have 2G on the VM - and  it was hung for > half a day.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I've found that compiling Ceph requires at least 8GB of RAM - anything
>>>>>>>>> less
>>>>>>>>> is a recipe for failure. I have not tried using cmake, though.
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Nathan Cutler
>>>>>>>>> Software Engineer Distributed Storage
>>>>>>>>> SUSE LINUX, s.r.o.
>>>>>>>>> Tel.: +420 284 084 037
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
