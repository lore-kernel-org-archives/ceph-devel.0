From: kefu chai <tchaikov@gmail.com>
Subject: Re: C++11, std::list::size(), and trusty
Date: Wed, 3 Jan 2018 22:53:15 +0800
Message-ID: <CAJE9aON3xV+C=VQuuwQxEG9auVmjnRa25RopDFo_UAHfXboPig@mail.gmail.com>
References: <alpine.DEB.2.11.1711101747120.2819@piezo.novalocal>
 <18fc68af-faef-3c4c-2f7d-4779ffda67a0@suse.cz> <alpine.DEB.2.11.1711301438010.8333@piezo.novalocal>
 <CAJE9aOPdtb0-u3N5ngtq9GrJG2pOMSpyOwtFa_nzgR79S9M7GQ@mail.gmail.com>
 <20171205164018.GA10722@ultraspiritum.eng.arb.redhat.com> <417b0d54-5ab2-4569-45fc-683c8c17826a@digiware.nl>
 <CAJ4mKGYxEeGKFonx_UBbYMiTcPh-4yGt8VuryoBFSQCbj8Pz-A@mail.gmail.com>
 <05f1ef85-e307-7c6b-17be-dbebe43dc824@digiware.nl> <CAJACTufEmyB_r0HKdF_CZH1kSC+e4gkxpJJPjn=mu-stFJkdhQ@mail.gmail.com>
 <CAJE9aOM2-G9sewdUchUrxHosRp17RUSS_CvzV1b4N7qPdRvV8w@mail.gmail.com>
 <CAJE9aOOOOROXmPXcwHJo_31-qdt9HmFdcpHuGZMarncfTpGOQA@mail.gmail.com>
 <CAJACTudfCvShHvZJAAZvqnCDifyR7NoEF__xsd+wRek-xW0jGA@mail.gmail.com>
 <CAJE9aOMeKX++y9+ktEN=ZJ=zua1zCVuMSdmV=ZCBUF_kp2qcBw@mail.gmail.com>
 <CALqRxCyhG6DrkpmoHQbS5TyATEXnwogSq5S5yPdcEKFAMiiq4Q@mail.gmail.com>
 <CAJE9aOMLUUM=ja+L7QCLmuDsTGZtvRBNJ+RmoWRW=O2sCsjRMw@mail.gmail.com> <alpine.DEB.2.11.1801021722370.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36999 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeACOxR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jan 2018 09:53:17 -0500
Received: by mail-qt0-f196.google.com with SMTP id f2so2367447qtj.4
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jan 2018 06:53:16 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801021722370.8186@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Xuehan Xu <xxhdx1985126@gmail.com>, Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>, Nathan Cutler <ncutler@suse.cz>, ceph-maintainers@ceph.com, Alfredo Deza <adeza@redhat.com>, James Page <james.page@ubuntu.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Wed, Jan 3, 2018 at 1:31 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 2 Jan 2018, kefu chai wrote:
>> On Tue, Jan 2, 2018 at 11:28 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
>> > On Tue, Dec 26, 2017 at 4:24 AM, kefu chai <tchaikov@gmail.com> wrote:
>> >> right. unless we swing our own homebrew gcc-7.
>> >
>> > Can we ask the devtoolset maintainers to change this option?
>> >
>> > I imagine they would be interested in this type of feedback from the field.
>>
>> https://git.centos.org/blob/rpms!devtoolset-7-gcc.git/2e5ef6c7934d4417e095855478736742b35bd0af/SPECS!gcc.spec#L1026
>
> For reference,
>
> ```
>   # Force the old ABI unconditionally, the new one does not work in the
>   # libstdc++_nonshared.a model against RHEL 6/7 libstdc++.so.6.
>   sed -i -e 's/\(define[[:blank:]]*_GLIBCXX_USE_DUAL_ABI[[:blank:]]*\)1/\10/' $f
> ```
>
>> I think we need to think about this before sending any inquiries to them.
>
> The problem I see is that it is impossible to write/build many native
> C++11 (or 14 or 17) apps with the toolchain since the old ABI precludes
> O(1) std::list.

i sort of agree with you. but i think we can still use C++11 (and
probably 14 or 17)
with the old ABI. see
https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html

<quote>
the choice of ABI to use is independent of the -std option used to
compile your code
</quote>

in other words, if we rely on the O(1) std::list and copy-on-write
string, then, yes,
we cannot write/build apps using this toolchain.

>
> If I'm following the _nonshared thing, it's a feature that lets you build
> with teh new toolchain but deploy on systems with much older libstdc++
> installed (new symbols are statically instead of dynamically linked).
> Is the problem with the "dual ABI" feature?

i think so. also by inspecting
https://git.centos.org/blob/rpms!devtoolset-7-gcc.git/c7/SOURCES!gcc7-libstdc++-compat.patch,
libstdc++_nonshared.a includes lots of C++98 and C++11 symbols. in the
case of list::size(), it is completely implemented in the header file.
but probably there are also some pieces of libstdc++ implemented in
the source files. in that case, it would be difficult to include both
ABIs a class, std::basic_string<> for example, in the same .a file.
because they are conditionalized by the "_GLIBCXX_USE_CXX11_ABI" macro
at build time. and they are both in the namespace of std::__cxx11
namespace.

will drop a mail to SCLs asking for more info on this.


-- 
Regards
Kefu Chai
