From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: ceph.spec.in problem in unstable ceph
Date: Thu, 5 Aug 2010 18:20:32 +0800
Message-ID: <AANLkTin42iX2iEuMfUCRPmAUwSttOq4GLLoQeR9gyidr@mail.gmail.com>
References: <AANLkTikzSGtffR3oZAwVNsa5RNtkFXx9HvazFBhf501L@mail.gmail.com>
	<Pine.LNX.4.64.1008040959130.16157@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51527 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab0HEKUd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Aug 2010 06:20:33 -0400
Received: by vws3 with SMTP id 3so5016679vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Aug 2010 03:20:33 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1008040959130.16157@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Just tested. the testing branch is ok, on Fedora 13.
The only problem I found in ceph.spec was that version was 0.21, not 0.=
22rc



On Thu, Aug 5, 2010 at 12:59 AM, Sage Weil <sage@newdream.net> wrote:
> Hi,
>
> I pushed a fix to the testing branch, but I don't have a Fedora VM ha=
ndy
> to test it. =A0Can you let me know if it resolves the problem?
>
> Thanks-
> sage
>
>
> On Wed, 4 Aug 2010, Xiaoguang Liu wrote:
>
>> rpmbuild fails at this line:
>>
>> chmod 0644 $RPM_BUILD_ROOT%{_sysconfdir}/ceph/sample.ceph.conf
>>
>> I think this is becuase sample.ceph.conf is no longer in /etc/ceph,
>> but %{_docdir}/, =A0in unstable .
>>
>> If I remove this line from spec file, rpmbuild fails at:
>>
>>
>> RPM build errors:
>> =A0 =A0 File not found:
>> /root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/samp=
le.ceph.conf
>> =A0 =A0 File not found:
>> /root/src/rpm/BUILDROOT/ceph-0.22rc-4.fc13.x86_64/usr/share/doc/samp=
le.fetch_config
>>
>> You may want to fix these two issues.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
