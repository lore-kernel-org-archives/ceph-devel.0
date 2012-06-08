From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph/OpenStack integration on Ubuntu precise: horribly broken, or
 am I doing something wrong?
Date: Fri, 8 Jun 2012 09:02:41 -0700
Message-ID: <CADvuQREhLJJcuaMXNj-a-iXNqaPjQ1-NLrimd1H=7a3a7pj0fw@mail.gmail.com>
References: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60964 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934356Ab2FHQDB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:03:01 -0400
Received: by dady13 with SMTP id y13so2529627dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 09:03:01 -0700 (PDT)
In-Reply-To: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org, Openstack <openstack@lists.launchpad.net>

On Fri, Jun 8, 2012 at 8:24 AM, Florian Haas <florian@hastexo.com> wrot=
e:
> This can of course all be fixed by using "upstream" packages from the
> Ceph guys (thanks to S=C3=A9bastien Han for pointing that out to me).

Yup. And I think that is the line you will be hearing for 12.04, I
believe. Use 12.04 as the base OS, then install newer ceph debs on top
of that.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
