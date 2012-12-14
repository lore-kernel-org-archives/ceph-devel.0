From: Stratos Psomadakis <psomas@grnet.gr>
Subject: Re: [PATCH] rbd: Add --json flag for the showmapped command
Date: Fri, 14 Dec 2012 10:57:20 +0200
Message-ID: <50CAE9F0.3020607@grnet.gr>
References: <50A6748C.7040303@inktank.com> <1355413032-18095-1-git-send-email-psomas@grnet.gr> <CAC-hyiF0Gga7rcML_2sk9gd+J7cR5uTTogR2crYsdSJB6O0NNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig968F6E9579E8F3DA7B2B15B8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:34618 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751652Ab2LNJMj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 14 Dec 2012 04:12:39 -0500
In-Reply-To: <CAC-hyiF0Gga7rcML_2sk9gd+J7cR5uTTogR2crYsdSJB6O0NNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig968F6E9579E8F3DA7B2B15B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/13/2012 07:17 PM, Yehuda Sadeh wrote:
> On Thu, Dec 13, 2012 at 7:37 AM, Stratos Psomadakis <psomas@grnet.gr> w=
rote:
>> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
>> ---
>> Hi Josh,
>>
>> This patch adds the '--json' flag to enable dumping the showmapped out=
put in
> I think that it should be "--format=3Djson" rather than --json. This
> will make it more in line with other tools. Also, then you could have
> the unpopular --format=3Dxml.

Hi,

the problem is that --format is arleady used in rbd (to select the rbd
image format). So, you could either use --output-format=3D for
plain/json/xml output (but then you would be inconsistent wrt the other
tools), or change --format to --image-format (or something like that),
and use --format to select the output formatting.

>
>> json format (as you suggested). I'm not sure if any other rbd subcomma=
nds could
>> make use of this flag (so the patch is showmapped-specific atm).
>>
>> Comments?
>>
>> Thanks,
>> Stratos
>>
>>  man/rbd.8  |    5 +++++
>>  src/rbd.cc |   54 +++++++++++++++++++++++++++++++++++++++++----------=
---
>>  2 files changed, 46 insertions(+), 13 deletions(-)
>>
>> diff --git a/man/rbd.8 b/man/rbd.8
>> index 6004244..7bf4c39 100644
>> --- a/man/rbd.8
>> +++ b/man/rbd.8
>> @@ -132,6 +132,11 @@ be open from more than one client at once, like d=
uring
>>  live migration of a virtual machine, or for use underneath
>>  a clustered filesystem.
>>  .UNINDENT
>> +.INDENT 0.0
>> +.TP
>> +.B \-\-json
>> +Dump output in json format (currently used only by showmapped).
>> +.UNINDENT
>>  .SH COMMANDS
>>  .INDENT 0.0
>>  .TP
>> diff --git a/src/rbd.cc b/src/rbd.cc
>> index 3db8978..82a72ba 100644
>> --- a/src/rbd.cc
>> +++ b/src/rbd.cc
>> @@ -47,6 +47,8 @@
>>  #include "include/rbd_types.h"
>>  #include "common/TextTable.h"
>>
>> +#include "common/Formatter.h"
>> +
>>  #if defined(__linux__)
>>  #include <linux/fs.h>
>>  #endif
>> @@ -126,7 +128,8 @@ void usage()
>>  "                               format 2 supports cloning\n"
>>  "  --id <username>              rados user (without 'client.' prefix)=
 to authenticate as\n"
>>  "  --keyfile <path>             file containing secret key for use wi=
th cephx\n"
>> -"  --shared <tag>               take a shared (rather than exclusive)=
 lock\n";
>> +"  --shared <tag>               take a shared (rather than exclusive)=
 lock\n"
>> +"  --json                       dump output in json format (currently=
 used only by showmapped)\n";
>>  }
>>
>>  static string feature_str(uint64_t features)
>> @@ -1198,7 +1201,7 @@ void do_closedir(DIR *dp)
>>      closedir(dp);
>>  }
>>
>> -static int do_kernel_showmapped()
>> +static int do_kernel_showmapped(bool dump_json)
>>  {
>>    int r;
>>    bool have_output =3D false;
>> @@ -1220,12 +1223,18 @@ static int do_kernel_showmapped()
>>      return r;
>>    }
>>
>> +  JSONFormatter jsf(false);
>>    TextTable tbl;
>> -  tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
>> -  tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
>> -  tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
>> -  tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
>> -  tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
>> +  if(dump_json =3D=3D false) {
>> +    tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
>> +    tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
>> +    tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
>> +    tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
>> +    tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
>> +  }
>> +  else {
>> +    jsf.open_object_section("devices");
>> +  }
>>
>>    do {
>>      if (strcmp(dent->d_name, ".") =3D=3D 0 || strcmp(dent->d_name, ".=
=2E") =3D=3D 0)
>> @@ -1262,13 +1271,30 @@ static int do_kernel_showmapped()
>>            << cpp_strerror(-r) << std::endl;
>>        continue;
>>      }
>> -
>> -    tbl << dent->d_name << pool << name << snap << dev << TextTable::=
endrow;
>> +
>> +    if (dump_json =3D=3D false) {
>> +      tbl << dent->d_name << pool << name << snap << dev << TextTable=
::endrow;
>> +    }
>> +    else {
>> +      jsf.open_object_section(dent->d_name);
>> +      jsf.dump_string("pool", pool);
>> +      jsf.dump_string("name", name);
>> +      jsf.dump_string("snap", snap);
>> +      jsf.dump_string("device", dev);
>> +      jsf.close_section();
>> +    }
>>      have_output =3D true;
>>
>>    } while ((dent =3D readdir(device_dir.get())));
>> -  if (have_output)
>> -    cout << tbl;
>> +
>> +  if (dump_json =3D=3D false) {
>> +    if (have_output)
>> +      cout << tbl;
>> +  }
>> +  else {
>> +    jsf.close_section();
>> +    jsf.flush(cout);
>> +  }
>>
>>    return 0;
>>  }
>> @@ -1505,7 +1531,7 @@ int main(int argc, const char **argv)
>>    const char *poolname =3D NULL;
>>    uint64_t size =3D 0;  // in bytes
>>    int order =3D 0;
>> -  bool format_specified =3D false;
>> +  bool format_specified =3D false, dump_json =3D false;
>>    int format =3D 1;
>>    uint64_t features =3D RBD_FEATURE_LAYERING;
>>    const char *imgname =3D NULL, *snapname =3D NULL, *destname =3D NUL=
L,
>> @@ -1579,6 +1605,8 @@ int main(int argc, const char **argv)
>>        imgname =3D strdup(val.c_str());
>>      } else if (ceph_argparse_witharg(args, i, &val, "--shared", (char=
 *)NULL)) {
>>        lock_tag =3D strdup(val.c_str());
>> +    } else if (ceph_argparse_flag(args, i, "--json", (char *) NULL)) =
{
>> +      dump_json =3D true;
>>      } else {
>>        ++i;
>>      }
>> @@ -2130,7 +2158,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
>>      break;
>>
>>    case OPT_SHOWMAPPED:
>> -    r =3D do_kernel_showmapped();
>> +    r =3D do_kernel_showmapped(dump_json);
>>      if (r < 0) {
>>        cerr << "rbd: showmapped failed: " << cpp_strerror(-r) << std::=
endl;
>>        return EXIT_FAILURE;
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Stratos Psomadakis
<psomas@grnet.gr>



--------------enig968F6E9579E8F3DA7B2B15B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDK6fMACgkQid1lVeNDMmBi9wCguHWZcijGodpqbUXlDyd2bF5h
4b8AoIEuQxnNMorIiatftqWZx82EzvGY
=NJ+L
-----END PGP SIGNATURE-----

--------------enig968F6E9579E8F3DA7B2B15B8--
