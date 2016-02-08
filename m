From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: hammer branch for v0.94.6 ready for QE
Date: Mon, 8 Feb 2016 13:21:10 -0800
Message-ID: <CAMMFjmFh9e2dM2ScPL1pj8eDN5k8Ndb7o5dog=-v7xE6gY7Tog@mail.gmail.com>
References: <56B843B7.1070002@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36442 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117AbcBHVVL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 16:21:11 -0500
Received: by mail-io0-f171.google.com with SMTP id g73so209559248ioe.3
        for <ceph-devel@vger.kernel.org>; Mon, 08 Feb 2016 13:21:10 -0800 (PST)
In-Reply-To: <56B843B7.1070002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

Loic

Copy and started testing today, thx

ceph-deploy question - I see that you had failures during integration
testing, what is the plan for those known issues?

Thx
YuriW

On Sun, Feb 7, 2016 at 11:28 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yuri,
>
> The hammer branch for v0.94.6 as found at https://github.com/ceph/cep=
h/commits/hammer has been approved by Greg, Yehuda, Josh and Sam and is=
 ready for QE. For the record, the head is https://github.com/ceph/ceph=
/commit/7abb6ae8f3cba67009bd022aaeee0a87cdfc6477 and the details of the=
 tests run are at http://tracker.ceph.com/issues/13356.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
