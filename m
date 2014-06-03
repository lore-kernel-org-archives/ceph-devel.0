From: Daniel Sterling <sterling.daniel@gmail.com>
Subject: Re: Official Ceph RPM build flags needed
Date: Tue, 3 Jun 2014 12:06:09 -0400
Message-ID: <CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58438 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbaFCQGL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 12:06:11 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so5179006qaq.37
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jun 2014 09:06:10 -0700 (PDT)
In-Reply-To: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The compiler flags are in the source RPM, is that correct?


On Tue, Jun 3, 2014 at 11:56 AM, Ilya Storozhilov
<Ilya_Storozhilov@epam.com> wrote:
> Hello Ceph-developers,
>
> at the moment we are doing some performance testing of Ceph v0.72.2 on ContOS 6.5, 64 bit. He have found, that Ceph from official RPM works faster that one which was compiled ourselves from sources. Do you know what compiler flags and configure options are actually used to build official Ceph PRM for CentOS? Maybe you can give an advise where to dig to find out what we need? :)
>
> Thank you very much!
>
> Best Regards,
> Ilya Storozhilov
> Lead Software Engineer
>
> EPAM Systems
> Tver office, Russia
> GMT+4
>
> EPAM Internal ext.:  55529
> Office phone:        +7 (4822) 630-070 ext. 55529
> Office fax:          +7 (4822) 630-073
> Mobile phone:        +7 (904) 021-0763
> E-mail:              Ilya_Storozhilov@epam.com
>
> http://www.epam.com
>
> CONFIDENTIALITY CAUTION AND DISCLAIMER
> This message is intended only for the use of the individual(s) or entity(ies) to which it is addressed and contains information that is legally privileged and confidential. If you are not the intended recipient, or the person responsible for delivering the  message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. All unintended recipients are obliged to delete this message and destroy any printed copies.
>
>          --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
