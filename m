From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: cephx auth
Date: Thu, 5 Apr 2012 09:58:22 -0700
Message-ID: <CAC-hyiGVvu=fsNRNRC4abZZfCL02dOLKNfmKn6dHOEA_r=AbTQ@mail.gmail.com>
References: <Pine.LNX.4.64.1204042317560.28065@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36709 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2DEQ6X convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 12:58:23 -0400
Received: by bkcik5 with SMTP id ik5so1540171bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Apr 2012 09:58:22 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204042317560.28065@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Apr 4, 2012 at 11:18 PM, Sage Weil <sage@newdream.net> wrote:
> Should we make cephx auth the default? =A0Currently it is still 'none=
', but
> this code is 2 years old now and I haven't seen an auth-related bug i=
n at
> least half a year.
>

Generally I agree. The reasons we didn't set cephx the default were
that we wanted to give it some spin while we cleared up any issues,
and I think we also wanted to reduce the cost of configuring ceph. For
most parts I think we're in the clear for both (unless libvirt is an
issue -- not too sure about that), so I'd say yes.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
