From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: teuthology-suite argument puzzle
Date: Thu, 13 Oct 2016 14:56:30 +0200
Message-ID: <CAOi1vP-QpF=0GLVUq_VScGhU7jJnmFUZUSSHXMWkOY4uvPfM2w@mail.gmail.com>
References: <57FF8326.4040209@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33839 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754918AbcJMNWw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 09:22:52 -0400
Received: by mail-qt0-f175.google.com with SMTP id q7so43867344qtq.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 06:22:52 -0700 (PDT)
In-Reply-To: <57FF8326.4040209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Zack Cerza <zack@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 13, 2016 at 2:50 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Zack,
>
> I wanted to try --rerun and ran into a cryptic error message:
>
> run=loic-2016-10-13_09:20:07-rgw-jewel-backports-distro-basic-smithi
> teuthology-suite -k distro --priority 101 --suite rgw --rerun $run --suite-branch jewel --email loic@dachary.org --ceph jewel-backports --machine-type smithi
> usage: teuthology-suite --help
>        teuthology-suite [-v | -vv ] --suite <suite> [options] [<config_yaml>...]
>        teuthology-suite [-v | -vv ] --rerun <name>  [options] [<config_yaml>...]
>
> What did I do wrong ?

Try w/o the --suite?  Just guessing - --suite gets inherited on --rerun.

Thanks,

                Ilya
