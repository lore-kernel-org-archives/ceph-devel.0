From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: Official Ceph RPM build flags needed
Date: Wed, 4 Jun 2014 09:40:17 +0200
Message-ID: <CAPed3OFsc0GCaH22DsMAgJL5+Tnktzc+bOMxUOoxbsgfRpj8MQ@mail.gmail.com>
References: <46cee548efee484b8edf2b24e0cc4340@EPBYMINSA0001.epam.com>
 <CAJZMiudJFUfWncXhkVncYOhzOXzkSLCgRYLrU=vTrFwDNSZykw@mail.gmail.com> <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:52629 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbaFDHkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 03:40:39 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so6612185pbc.18
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 00:40:39 -0700 (PDT)
In-Reply-To: <285a083a91ed4cb6867d0a86e9bbda0b@EPBYMINSA0001.epam.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Cc: Daniel Sterling <sterling.daniel@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 3, 2014 at 6:19 PM, Ilya Storozhilov
<Ilya_Storozhilov@epam.com> wrote:
> So it seems, that this is up to packager what to put to RPM_OPT_FLAGS environment variable on packaging. Maybe someone knows what particular value is used?
> Thank you!

You can see what the actual value is by running:
$ rpm --eval '%{optflags}'
-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions
-fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic

Hope it helps,

Ruben Kerkhof
