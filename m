From: Patrick McGarry <patrick@inktank.com>
Subject: Re: [Ceph-community] v0.75 contributors credits ( experimental)
Date: Wed, 15 Jan 2014 10:52:55 -0500
Message-ID: <CAP8Oy=K6KbVO=whGNBjqe2tZoGmPEsHRdmK8t9KNYUHSuG-XXQ@mail.gmail.com>
References: <52D6450E.1090605@dachary.org>
	<CACEfbZgrHbCFGPXkTSsO=kWZycOoZTKC_xJWpnDhqX4gw7+hHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:40989 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaAOPw4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 10:52:56 -0500
Received: by mail-pd0-f175.google.com with SMTP id r10so1269167pdi.6
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jan 2014 07:52:56 -0800 (PST)
In-Reply-To: <CACEfbZgrHbCFGPXkTSsO=kWZycOoZTKC_xJWpnDhqX4gw7+hHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Woodward <xarses@gmail.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

Andrew,

We have some of that at metrics.ceph.com (and are planning to add a
release-specific aspect to it).  What parts of stackalytics do you
think are the best things to include?  Right now I'm thinking of the
following for each tagged major release:

* new committers
* total committers during this release cycle
* lines of code added
* commits
* list messages during the release cycle
* irc messages during release cycle
* Activity per repository this release cycle (perhaps we can help
break out by module: rgw/rbd/mds/rados/core?)

Anything I'm missing?



Best Regards,

Patrick McGarry
Director, Community || Inktank
http://ceph.com  ||  http://inktank.com
@scuttlemonkey || @ceph || @inktank


On Wed, Jan 15, 2014 at 10:47 AM, Andrew Woodward <xarses@gmail.com> wr=
ote:
> Loric,
>
> Have you seen the stackalytics project that we use for OpenStack?
>
> http://www.stackalytics.com/
> https://github.com/Mirantis/stackalytics
>
>
>
> On Wed, Jan 15, 2014 at 12:21 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>
>> Hi Ceph,
>>
>> Here is a sorted list of authors and organizations who contributed t=
o
>> v0.75, by number of commits or reviews back to v0.74. The affiliatio=
n of
>> authors to organizations can be updated by submitting a patch to
>> https://github.com/ceph/ceph/blob/master/.organizationmap
>>
>> If you are curious about how it is done, the details are at the end =
of
>> this mail.
>>
>> Commits by authors
>>      1      104 Sage Weil <sage@inktank.com>
>>      2       86 Loic Dachary <loic@dachary.org>
>>      3       18 Noah Watkins <noah.watkins@inktank.com>
>>      4       12 David Zafman <david.zafman@inktank.com>
>>      5        8 Josh Durgin <josh.durgin@inktank.com>
>>      6        7 John Wilkins <john.wilkins@inktank.com>
>>      7        6 Samuel Just <sam.just@inktank.com>
>>      8        4 Yan, Zheng <zheng.z.yan@intel.com>
>>      9        3 Ken Dreyer <ken.dreyer@inktank.com>
>>     10        2 Yehuda Sadeh <yehuda@inktank.com>
>>     11        2 Greg Farnum <greg@inktank.com>
>>     12        2 Gary Lowell <gary.lowell@inktank.com>
>>     13        2 David Moreau Simard <dmsimard@iweb.com>
>>     14        2 Christophe Courtaut <christophe.courtaut@gmail.com>
>>     15        1 Yan, Zheng <ukernel@gmail.com>
>>     16        1 Xihui He <xihuihe@gmail.com>
>>     17        1 Rutger ter Borg <rutger@terborg.net>
>>     18        1 Kun Huang <academicgareth@gmail.com>
>>     19        1 Jonathan Dieter <jdieter@lesbg.com>
>>     20        1 Dan Mick <dan.mick@inktank.com>
>>     21        1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
>>     22        1 Andreas Peters <andreas.joachim.peters@cern.ch>
>> Commits by organizations
>>      1      165 Inktank <contact@inktank.com>
>>      2       88 Cloudwatt <libre.licensing@cloudwatt.com>
>>      3        4 Intel <contact@intel.com>
>>      4        2 IWeb <contact@iweb.com>
>>      5        1 Yan, Zheng <ukernel@gmail.com>
>>      6        1 Xihui He <xihuihe@gmail.com>
>>      7        1 Rutger ter Borg <rutger@terborg.net>
>>      8        1 Kun Huang <academicgareth@gmail.com>
>>      9        1 Jonathan Dieter <jdieter@lesbg.com>
>>     10        1 CERN <contact@cern.ch>
>>     11        1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
>> Reviews by authors
>>      1       28 Sage Weil <sage@inktank.com>
>>      2        6 Loic Dachary <loic@dachary.org>
>>      3        6 Josh Durgin <josh.durgin@inktank.com>
>>      4        3 Samuel Just <sam.just@inktank.com>
>>      5        2 Yan, Zheng <zheng.z.yan@intel.com>
>>      6        2 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
>>      7        2 Greg Farnum <greg@inktank.com>
>>      8        2 Dan Mick <dan.mick@inktank.com>
>>      9        1 Yehuda Sadeh <yehuda@inktank.com>
>>     10        1 Roald J. van Loon <roald@roaldvanloon.nl>
>>     11        1 Noah Watkins <noah.watkins@inktank.com>
>>     12        1 David Moreau Simard <dmsimard@iweb.com>
>>     13        1 Andreas Peters <andreas.joachim.peters@cern.ch>
>> Reviews by organizations
>>      1       45 Inktank <contact@inktank.com>
>>      2        6 Cloudwatt <libre.licensing@cloudwatt.com>
>>      3        2 Intel <contact@intel.com>
>>      4        1 Roald van Loon Consultancy <roald@roaldvanloon.nl>
>>      5        1 IWeb <contact@iweb.com>
>>      6        1 CERN <contact@cern.ch>
>>
>> The script used to generate this output is (copy paste at the root o=
f a
>> git clone https://github.com/ceph/ceph.git):
>>
>> cat > credits.sh <<'EOF'
>> previous_version=3D$1
>> next_version=3D$2
>>
>> echo "Commits by authors"
>> git log --after $previous_version --before $next_version --pretty=3D=
'%aN
>> <%aE>' | sort | uniq -c | sort -rn | nl
>> echo "Commits by organizations"
>> git log --after $previous_version --before $next_version --pretty=3D=
'%aN
>> <%aE>' | git -c mailmap.file=3D.organizationmap check-mailmap --stdi=
n | sort |
>> uniq -c | sort -rn | nl
>> echo "Reviews by authors"
>> git log --after $previous_version --before $next_version --pretty=3D=
%b |
>> perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' =
| git
>> check-mailmap --stdin | sort | uniq -c | sort -rn | nl
>> echo "Reviews by organizations"
>> git log --after $previous_version --before $next_version --pretty=3D=
%b |
>> perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' =
| git
>> check-mailmap --stdin | git -c mailmap.file=3D.organizationmap check=
-mailmap
>> --stdin | sort | uniq -c | sort -rn | nl
>> EOF
>> v0_74=3D2013-12-30 ; v0_75=3D2014-01-14 ; bash credits.sh $v0_74 $v0=
_75
>>
>> Authors names are normalized with .mailmap and authors affiliations =
to a
>> given organization comes from .organizationmap, both of which can be=
 found
>> and patched at the root of the ceph source tree.
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>>
>> _______________________________________________
>> Ceph-community mailing list
>> Ceph-community@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-community-ceph.com
>>
>
>
>
> --
> If google has done it, Google did it right!
>
> _______________________________________________
> Ceph-community mailing list
> Ceph-community@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-community-ceph.com
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
