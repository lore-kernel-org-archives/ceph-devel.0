From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: [BUG]  ceph 0.23 ,sudo /etc/init.d/init-ceph  cleanalllogs ,
 delete /   folder
Date: Fri, 3 Dec 2010 09:01:47 +0800
Message-ID: <1291338107.1757.92.camel@cephhost>
References: <1291274740.1757.85.camel@cephhost>
	 <Pine.LNX.4.64.1012021121230.1982@cobra.newdream.net>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:18891 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758209Ab0LCBAa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Dec 2010 20:00:30 -0500
In-Reply-To: <Pine.LNX.4.64.1012021121230.1982@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "gregf@hq.newdream.net" <gregf@hq.newdream.net>, "yehuda@hq.newdream.net" <yehuda@hq.newdream.net>, "colinm@hq.newdream.net" <colinm@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>, Kevin Chen <wchen@tnsoft.com.cn>



=E5=9C=A8 2010-12-03=E4=BA=94=E7=9A=84 03:22 +0800=EF=BC=8CSage Weil=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi Jeff,
>=20
> On Thu, 2 Dec 2010, Jeff Wu wrote:
> > [...]
> > Look into init-ceph codes, should be "$log_sym_dir/* " equal to  "/=
*",
> > "cleanlogs" command also exist this issue. init-ceph script might b=
e add
> > a check for "$log_dir" and "$log_sym_dir".
>=20
> This was updated in the 'rc' branch (soon to be 0.24).  It's now
>=20
> 	cleanlogs)
> 	    echo removing logs
> 	    if [ -n "$log_sym_dir" ]; then
> 		do_cmd "for f in $log_sym_dir/$type.$id.*; do rm -f=20
> \`readlink \$f\` ; rm -f \$f ; done ; rm -f $log_dir/$type.$id.*"
> 	    fi
> 	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/$type.$id.*"
> 	    ;;
>=20
> 	cleanalllogs)
> 	    echo removing all logs
> 	    [ -n "$log_sym_dir" ] && do_cmd "rm -f $log_sym_dir/* || true"
> 	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/* || true"
> 	    ;;
>=20
> > and If we detect some of bugs ,does it update to=20
> > http://tracker.newdream.net/projects/ceph ?
> >=20
> > if yes ,how ?
>=20
> Yes, please.  You can create an account, log in, and then click the '=
new=20
> issue' button along the top.  In this case the issue is fixed for the=
 next=20
> release though (I believe?) so we should be okay.

Hi ,sage, thank you for your reply so quickly.



>=20
> Thanks!
> sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
