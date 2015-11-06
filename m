From: Abhishek Varshney <abhishek.varshney@flipkart.com>
Subject: Re: a home for backport snippets
Date: Fri, 6 Nov 2015 11:41:57 +0530
Message-ID: <CAP3mxSzcET62u7zJCUtMv56Xjkr_29HN4qhj_H4b-XsxRNf2SA@mail.gmail.com>
References: <563B5789.7050006@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35758 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbbKFGL7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 01:11:59 -0500
Received: by lbbes7 with SMTP id es7so50795500lbb.2
        for <ceph-devel@vger.kernel.org>; Thu, 05 Nov 2015 22:11:57 -0800 (PST)
In-Reply-To: <563B5789.7050006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

It is definitely a great idea to have all the backport snippets under
a roof. However, these snippets, which are mostly a set of commands,
provide great flexibility in terms of configuration and the ability to
partly execute them. For instance, if I see conflicts while preparing
an integration branch, I comment out the git fetch, checkout and reset
steps from [1] after resolving the conflicts and re-run the snippet.
It would be nice if we can incorporate all the snippets and take
ceph-workbench to that level of flexibility :)

[1] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_=
the_integration_branch

Thanks
Abhishek

On Thu, Nov 5, 2015 at 6:50 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> Today, Nathan and I briefly discussed the idea of collecting the back=
port snippets that are archived in the wiki at http://tracker.ceph.com/=
projects/ceph-releases/wiki/HOWTO. We all have copies on our local disk=
s and although they don't diverge much, this is not very sustainable. I=
t was really good as we established the backport workflows. And it woul=
d have been immensely painful to maintain a proper software while we we=
re changing the workflow on a regular basis. But it looks like we now h=
ave something stable.
>
> Early this year ceph-workbench[1] was started with the idea of helpin=
g with backports. It is a mostly empty shell we can now use to collect =
all the snippets we have. Instead of adding set-release[2] to the scrip=
t directory of Ceph, it would be a subcommand of ceph-workbench, like s=
o:
>
>   ceph-workbench set-release --token $github_token --key $redmine_key
>
> What do you think ?
>
> Cheers
>
> [1] https://pypi.python.org/pypi/ceph-workbench
> [2] https://github.com/ceph/ceph/pull/6466
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
