From: Wido den Hollander <wido@42on.com>
Subject: Re: v0.77 contributors credits
Date: Fri, 21 Feb 2014 22:17:20 +0100
Message-ID: <5307C260.9040900@42on.com>
References: <53071F60.30500@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:47678 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbaBUVRX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Feb 2014 16:17:23 -0500
In-Reply-To: <53071F60.30500@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

On 02/21/2014 10:41 AM, Loic Dachary wrote:
> Hi Ceph,
>
> Here is a sorted list of authors and organizations who contributed to=
 v0.77, by number of commits or reviews back to v0.76. The affiliation =
of authors to organizations can be updated by submitting a patch to htt=
ps://github.com/ceph/ceph/blob/master/.organizationmap
>
> All commits are reviewed but the number of reviews is a fraction of t=
he number of commits. More often than not, the reviewer(s) is only ment=
ioned in the message of the merge although it means that all associated=
 commits have been reviewed.
>
> If you are curious about how it is done, the details are at the end o=
f this mail.
>

Thanks Loic! Great to see so many people contributing to Ceph! I never=20
figured it were so many people from different organizations.

Very valuable information!

Wido

> Commits by authors
>       1	     75 Yehuda Sadeh <yehuda@inktank.com>
>       2	     70 Sage Weil <sage@inktank.com>
>       3	     66 Samuel Just <sam.just@inktank.com>
>       4	     42 Greg Farnum <greg@inktank.com>
>       5	     36 Loic Dachary <loic@dachary.org>
>       6	     24 John Wilkins <john.wilkins@inktank.com>
>       7	     23 Li Wang <liwang@ubuntukylin.com>
>       8	     13 Josh Durgin <josh.durgin@inktank.com>
>       9	      9 Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
>      10	      8 Noah Watkins <noah.watkins@inktank.com>
>      11	      8 Ilya Dryomov <ilya.dryomov@inktank.com>
>      12	      7 David Zafman <david.zafman@inktank.com>
>      13	      4 Ken Dreyer <ken.dreyer@inktank.com>
>      14	      4 Haomai Wang <haomaiwang@gmail.com>
>      15	      3 Wido den Hollander <wido@42on.com>
>      16	      3 John Spray <john.spray@inktank.com>
>      17	      2 Ray Lv <xiangyulv@gmail.com>
>      18	      2 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
>      19	      1 Moritz M=F6ller <mm@mxs.de>
>      20	      1 Kai Zhang <zakir.exe@gmail.com>
>      21	      1 Eric Mourgaya <eric.mourgaya@arkea.com>
>      22	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
>      23	      1 Derek Yarnell <derek@umiacs.umd.edu>
>      24	      1 Dan Mick <dan.mick@inktank.com>
>      25	      1 Concubidated <tyler.brekke@inktank.com>
>      26	      1 Christian Marie <pingu@anchor.net.au>
>      27	      1 Alexandre Marangone <alexandre.marangone@inktank.com>
> Commits by organizations
>       1	    334 Inktank <contact@inktank.com>
>       2	     36 Cloudwatt <libre.licensing@cloudwatt.com>
>       3	     23 Ubuntu Kylin <contact@ubuntukylin.com>
>       4	      4 UnitedStack <contact@unitedstack.com>
>       5	      3 Wido 42on <contact@42on.com>
>       6	      2 Yahoo! <contact@yahoo-inc.com>
>       7	      1 University of Mississippi <contact@umd.edu>
>       8	      1 Debian GNU/Linux <contact@debian.org>
>       9	      1 Credit Mutuel Arkea <contact@arkea.com>
>      10	      1 CISCO <contact@cisco.com>
>      11	      1 Bigpoint.com <contact@bigpoint.net>
>      12	      1 Anchor Hosting <contact@anchor.com.au>
> Reviews by authors (one review spans multiple commits)
>       1	     31 Sage Weil <sage@inktank.com>
>       2	     13 Josh Durgin <josh.durgin@inktank.com>
>       3	      9 Greg Farnum <greg@inktank.com>
>       4	      6 Samuel Just <sam.just@inktank.com>
>       5	      2 Loic Dachary <loic@dachary.org>
>       6	      2 Christophe Courtaut <christophe.courtaut@gmail.com>
>       7	      1 Yehuda Sadeh <yehuda@inktank.com>
>       8	      1 Yan, Zheng <zheng.z.yan@intel.com>
>       9	      1 Thomas Bechtold <t.bechtold@telekom.de>
>      10	      1 Rutger ter Borg <rutger@terborg.net>
>      11	      1 Laurent Barbe <laurent@ksperis.com>
>      12	      1 Kai Zhang <zakir.exe@gmail.com>
>      13	      1 Jonathan Dieter <jdieter@lesbg.com>
>      14	      1 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
>      15	      1 Huang Jun <hjwsm1989@gmail.com>
>      16	      1 Derek Yarnell <derek@umiacs.umd.edu>
>      17	      1 David Zafman <david.zafman@inktank.com>
>      18	      1 Dan Chai <tengweicai@gmail.com>
>      19	      1 Christian Marie <pingu@anchor.net.au>
>      20	      1 Alan Somers <asomers@gmail.com>
> Reviews by organizations (one review spans multiple commits)
>       1	     62 Inktank <contact@inktank.com>
>       2	      4 Cloudwatt <libre.licensing@cloudwatt.com>
>       3	      2 Unaffiliated <no@organization.net>
>       4	      1 University of Mississippi <contact@umd.edu>
>       5	      1 Spectra Logic <contact@spectralogic.com>
>       6	      1 Lebanon Evangelical School <contact@lesbg.com>
>       7	      1 Intel <contact@intel.com>
>       8	      1 Deutsche Telekom <contact@telekom.de>
>       9	      1 CISCO <contact@cisco.com>
>      10	      1 CCM Benchmark <contact@ccmbenchmark.com>
>      11	      1 ArtiBit <contact@artibit.com>
>      12	      1 Anchor Hosting <contact@anchor.com.au>
>
> The script used to generate this output is (copy paste at the root of=
 a git clone https://github.com/ceph/ceph.git):
>
> cat > credits.sh <<'EOF'
> range=3D$1
> echo "Commits by authors"
> git log --pretty=3D'%aN <%aE>' $range | sort | uniq -c | sort -rn | n=
l
> echo "Commits by organizations"
> git log --pretty=3D'%aN <%aE>' $range | git -c mailmap.file=3D.organi=
zationmap check-mailmap --stdin | sort | uniq -c | sort -rn | nl
> echo "Reviews by authors (one review spans multiple commits)"
> git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Revi=
ewed-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | sort | uniq=
 -c | sort -rn | nl
> echo "Reviews by organizations (one review spans multiple commits)"
> git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Revi=
ewed-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | git -c mail=
map.file=3D.organizationmap check-mailmap --stdin | sort | uniq -c | so=
rt -rn | nl
> EOF
> bash credits.sh tags/v0.76...tags/v0.77
>
> Authors names are normalized with .mailmap and authors affiliations t=
o a given organization comes from .organizationmap, both of which can b=
e found and patched at the root of the ceph source tree.
>
> More sophisticated reports can be generated and visualized by tools s=
uch as http://bitergia.com/ or http://stackalytics.com/. Cheers
>


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
