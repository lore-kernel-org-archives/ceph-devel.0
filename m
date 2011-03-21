From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: RPM issues
Date: Mon, 21 Mar 2011 09:22:35 -0700
Message-ID: <AANLkTi=Q=49N5zKB51+VHimOM5K4Vn+TovwtqS_Zz2Oe@mail.gmail.com>
References: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
	<20110321160950.GA17804@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64295 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1CUQWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2011 12:22:43 -0400
Received: by bwz15 with SMTP id 15so5150131bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2011 09:22:42 -0700 (PDT)
In-Reply-To: <20110321160950.GA17804@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

On Mon, Mar 21, 2011 at 9:09 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> On Fri, Mar 18, 2011 at 05:29:51PM -0700, Colin McCabe wrote:
>> 3. How should we handle tcmalloc, if at all? Google-perftools is not
>> bundled for 64 bit on CentOS. (It seems like this decision was made
>> because some of the stuff in this package is buggy on 64 bit x86.
>> However, tcmalloc itself is not buggy on 64 bit.). And in general, how
>> do we handle things that are "good to have" but which shouldn't be
>> dependencies?
>
> Hmm. The whole point of commit a2c02d was that it'd be harder to
> accidentally build a non-desired variant of Ceph. That is, just
> because you reinstalled the machine you use for building the package,
> and forgot to install libatomic-ops-dev, doesn't mean you should
> create packages with completely different behavior in the future.
>
> So, you need to figure out whether libatomic-ops is desired or not,
> for the relevant platform/architecture. If yes, then builds must fail
> without it (./configure will complain, debs have build-dependency). If
> not, then say ./configure --without-libatomic-ops. But don't let it
> depend on unpredictable factors.

I agree that libatomic-ops should be mandatory.

The more annoying dependencies are things like GTK2, which don't
really affect the behavior of the rest of the project, but which will
have to be "mandatory" in the RPM, it seems. Also, as I said, tcmalloc
will present somewhat of a problem because it's just not packaged on
RedHat/CentOS at the moment for 64-bit. I will report a bug with Red
Hat and see what they think...

cheers,
Colin
