From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: undefined references in luminous for librados-devel
Date: Fri, 15 Sep 2017 14:14:32 +1000
Message-ID: <CAF-wwdGLZqvEQOJyS1cTLDLfK5ndfDaPyzoN_oXPjvOxkWxV3A@mail.gmail.com>
References: <CAB2gnbWciSJmZzREHqJvz5Ae=uD+_5TkgkNcaYr+swxYe2iXAA@mail.gmail.com>
 <alpine.DEB.2.11.1709142130100.16664@piezo.novalocal> <CAB2gnbVgqvWFj8ivicYHqiMt9QRAGdKN49Mu-xPZKNOnBh3TWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:56202 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdIOEOd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Sep 2017 00:14:33 -0400
Received: by mail-it0-f44.google.com with SMTP id 4so2316375itv.4
        for <ceph-devel@vger.kernel.org>; Thu, 14 Sep 2017 21:14:33 -0700 (PDT)
In-Reply-To: <CAB2gnbVgqvWFj8ivicYHqiMt9QRAGdKN49Mu-xPZKNOnBh3TWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 15, 2017 at 7:40 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> Yeh, thanks, I just noticed this:
>
> On the Fedora nodes the following works `c++
> -D_GLIBCXX_USE_CXX11_ABI=0 --std=c++11 -Wall test.cc -lrados`, and on
> CentOS 7, either 0 or 1 works for the CXX11_ABI variable.
>
> The docs say "When defined to a non-zero value [the CXX11_ABI
> variable] the library headers will use the new C++11-conforming ABI
> introduced in GCC 5, rather than the older ABI introduced in GCC 3.4".
>
> Makes sense. I guess I expected issues like this to be filtered out /
> caught through rpm magic. Know of any CMake magic macros that can turn
> those flags on?

You can try these if you want?

https://copr.fedorainfracloud.org/coprs/badone/ceph-luminous/build/602668/

Not official of course, but probably (maybe?) better than what you're using now?

>
> On Thu, Sep 14, 2017 at 2:31 PM, Sage Weil <sage@newdream.net> wrote:
>> On Thu, 14 Sep 2017, Noah Watkins wrote:
>>> Running into some undefined references linking against librados in
>>> Luminous. Installed using RPM repo instructions from Ceph docs. Note
>>> this issue shows up on Fedora 23,24,25, but not on CentOS 7.
>>
>> It looks a bit like these are C++ ABI differences because you are using
>> el7 libraries on an fc25 box, which probably has a different
>> version of gcc, libraries, etc?
>>
>> sage
>>
>>
>>> # Test program
>>>
>>> [root@0ac98bfcffa2 build]# cat test.cc
>>> #include <rados/librados.hpp>
>>>
>>> int main(int argc, char **argv)
>>> {
>>>   librados::IoCtx ioctx;
>>>   return ioctx.create("foo", true);
>>> }
>>>
>>> # Linking error
>>>
>>> [root@0ac98bfcffa2 build]# c++ --std=c++11 -Wall test.cc -lrados
>>> /tmp/cc4MZnFR.o: In function `main':
>>> test.cc:(.text+0x51): undefined reference to
>>> `librados::IoCtx::create(std::__cxx11::basic_string<char,
>>> std::char_traits<char>, std::allocator<char> > const&, bool)'
>>> collect2: error: ld returned 1 exit status
>>>
>>> # Looks like everything is installed correctly.
>>>
>>> [root@0ac98bfcffa2 build]# librados-config --version
>>> ceph version 12.2.0 (32ce2a3ae5239ee33d6150705cdb24d43bab910c) luminous (rc)
>>>
>>> [root@0ac98bfcffa2 build]# rpm -qa | grep 'rados\|ceph'
>>> python-rados-12.2.0-0.el7.x86_64
>>> python-cephfs-12.2.0-0.el7.x86_64
>>> ceph-selinux-12.2.0-0.el7.x86_64
>>> ceph-osd-12.2.0-0.el7.x86_64
>>> librados2-12.2.0-0.el7.x86_64
>>> libradosstriper1-12.2.0-0.el7.x86_64
>>> ceph-base-12.2.0-0.el7.x86_64
>>> ceph-mds-12.2.0-0.el7.x86_64
>>> ceph-mon-12.2.0-0.el7.x86_64
>>> ceph-12.2.0-0.el7.x86_64
>>> libcephfs2-12.2.0-0.el7.x86_64
>>> ceph-common-12.2.0-0.el7.x86_64
>>> ceph-mgr-12.2.0-0.el7.x86_64
>>> librados-devel-12.2.0-0.el7.x86_64
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
Cheers,
Brad
