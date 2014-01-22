From: Guang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Ceph cluster is unreachable because of
	authentication failure
Date: Wed, 22 Jan 2014 19:34:14 +0800
Message-ID: <BLU0-SMTP45470BC6BBFC330988AD1B9DFA70@phx.gbl>
References: <BLU0-SMTP1356EEDE6A8ACF94947F22ADFBF0@phx.gbl>
	<alpine.DEB.2.00.1401140654500.10628@cobra.newdream.net>
	<016D7F31-523E-4EC1-8222-7D4084BA400F@outlook.com>
	<BLU0-SMTP14487458FBE42B33537BD4EDFB90@phx.gbl>
	<alpine.DEB.2.00.1401160908170.3044@cobra.newdream.net>
	<BLU0-SMTP169D80D759610D226681DD3DFB80@phx.gbl>
	<alpine.DEB.2.00.1401170804180.304@cobra.newdream.net>
	<BLU0-SMTP65962E190D657BC79CFBB2DFBA0@phx.gbl>
	<alpine.DEB.2.00.1401200835050.2149@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1401200835050.2149-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Thanks Sage.

If we use the debug_mon and debug_paxos as 20, the log file is growing =
too fast, I set the log level as 10 and then: 1) run the 'ceph osd set =
noin' command, 2) grep the log with keyword 'noin', attached is the =
monitor log. Please help to check. Thanks very much!

--Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96
Content-Disposition: attachment; filename="mon_osd_set_noin_hang.txt"
Content-Type: text/plain; x-unix-mode=0644; name="mon_osd_set_noin_hang.txt"
Content-Transfer-Encoding: quoted-printable

2014-01-21 12:24:03.851372 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273067662 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2491b200 =
con 0x301c8e0
2014-01-21 12:24:03.851405 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:24:03.851411 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:24:07.515533 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273091844 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x249cb980 =
con 0x301c8e0
2014-01-21 12:24:07.515578 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:24:07.515588 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:24:27.198169 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:24:28.412895 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:24:48.815132 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:24:53.029481 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273116132 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x17993980 =
con 0x301c8e0
2014-01-21 12:24:53.029525 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:24:53.029534 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:25:16.754558 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:25:18.215278 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273140317 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1f178780 =
con 0x301c8e0
2014-01-21 12:25:18.215327 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:25:18.215336 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:25:39.689524 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:25:43.915315 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273164608 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x21cf2f80 =
con 0x301c8e0
2014-01-21 12:25:43.915344 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:25:43.915350 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:25:48.113328 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273189107 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xba25500 =
con 0x301c8e0
2014-01-21 12:25:48.113357 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:25:48.113362 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:08.210631 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:09.474338 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:30.314818 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:34.724654 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273213195 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x13a52080 =
con 0x301c8e0
2014-01-21 12:26:34.724683 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:26:34.724689 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:39.241503 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273237403 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2a7beb80 =
con 0x301c8e0
2014-01-21 12:26:39.241533 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:26:39.241539 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:57.721786 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:26:58.892716 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:27:20.739196 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:27:25.405511 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273261497 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xe794600 =
con 0x301c8e0
2014-01-21 12:27:25.405539 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:27:25.405545 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:27:48.802763 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:27:50.017238 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273286009 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x27a64d80 =
con 0x301c8e0
2014-01-21 12:27:50.017268 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:27:50.017274 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:28:11.326143 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:28:15.486421 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273310107 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x27cfee00 =
con 0x301c8e0
2014-01-21 12:28:15.486466 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:28:15.486475 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:28:37.664040 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:28:38.609918 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273334208 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23e50500 =
con 0x301c8e0
2014-01-21 12:28:38.609964 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:28:38.609977 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:28:58.422161 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:02.575579 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273358417 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1b020c80 =
con 0x301c8e0
2014-01-21 12:29:02.575609 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:29:02.575616 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:07.022398 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273383143 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1b021400 =
con 0x301c8e0
2014-01-21 12:29:07.022428 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:29:07.022434 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:24.110039 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:25.275149 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:26.221565 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:46.143811 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:50.003732 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273407220 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23979e00 =
con 0x301c8e0
2014-01-21 12:29:50.003759 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:29:50.003765 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:29:54.657933 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273431666 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x27755000 =
con 0x301c8e0
2014-01-21 12:29:54.657962 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:29:54.657968 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:30:13.984553 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:30:15.203360 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:30:36.490604 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:30:40.233850 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273455775 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1a6a9180 =
con 0x301c8e0
2014-01-21 12:30:40.233895 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:30:40.233905 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:30:45.070754 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273479992 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1dbebe80 =
con 0x301c8e0
2014-01-21 12:30:45.070799 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:30:45.070808 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:04.239980 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:05.216624 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:25.616910 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:29.304254 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273504726 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x739b200 =
con 0x301c8e0
2014-01-21 12:31:29.304282 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:31:29.304287 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:34.011713 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273528838 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2c781900 =
con 0x301c8e0
2014-01-21 12:31:34.011742 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:31:34.011748 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:52.517705 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:31:53.467222 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:32:18.857804 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:32:23.182206 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273553344 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1f92b700 =
con 0x301c8e0
2014-01-21 12:32:23.182235 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:32:23.182241 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:32:46.693447 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:32:47.671134 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273577801 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x274a5f00 =
con 0x301c8e0
2014-01-21 12:32:47.671186 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:32:47.671195 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:08.137009 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:12.924730 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273601982 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xdff6680 =
con 0x301c8e0
2014-01-21 12:33:12.924758 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:33:12.924763 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:16.838721 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273626561 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1d079900 =
con 0x301c8e0
2014-01-21 12:33:16.838749 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:33:16.838754 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:35.833743 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:37.051731 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:33:57.556307 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:01.891963 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273650685 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2ad5d280 =
con 0x301c8e0
2014-01-21 12:34:01.891993 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:34:01.891999 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:05.449695 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273675120 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2c634600 =
con 0x301c8e0
2014-01-21 12:34:05.449723 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:34:05.449728 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:25.386430 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:26.664077 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:39.293399 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273699199 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2734d780 =
con 0x301c8e0
2014-01-21 12:34:39.293428 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:34:39.293434 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:56.764995 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:34:57.929211 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:35:20.750150 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:35:25.637025 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273723382 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x17f1d500 =
con 0x301c8e0
2014-01-21 12:35:25.637053 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:35:25.637059 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:35:48.284640 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:35:49.529835 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273747931 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x20125a00 =
con 0x301c8e0
2014-01-21 12:35:49.529865 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:35:49.529871 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:11.182698 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:15.910868 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273772064 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x141c6400 =
con 0x301c8e0
2014-01-21 12:36:15.910894 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:36:15.910900 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:19.889472 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273796304 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xb425780 =
con 0x301c8e0
2014-01-21 12:36:19.889502 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:36:19.889508 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:42.184570 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:42.632321 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:46.834339 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273820846 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23e0df00 =
con 0x301c8e0
2014-01-21 12:36:46.834368 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:36:46.834374 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:36:51.260742 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273844985 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1ebbd500 =
con 0x301c8e0
2014-01-21 12:36:51.260770 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:36:51.260776 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:10.540199 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:11.907893 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:12.528533 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:16.599247 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273869117 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x10f56180 =
con 0x301c8e0
2014-01-21 12:37:16.599275 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:37:16.599281 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:37.940171 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:39.336286 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:37:40.310657 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273893470 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23e03480 =
con 0x301c8e0
2014-01-21 12:37:40.310739 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:37:40.310748 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:04.774140 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:06.103501 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273918065 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x27b96400 =
con 0x301c8e0
2014-01-21 12:38:06.103530 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:38:06.103536 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:13.357586 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273942274 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1d848780 =
con 0x301c8e0
2014-01-21 12:38:13.357618 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:38:13.357624 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:33.608010 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:34.222574 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:39.043513 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273966619 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x26ba6900 =
con 0x301c8e0
2014-01-21 12:38:39.043542 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:38:39.043548 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:38:43.090934 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 273991283 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x253dc380 =
con 0x301c8e0
2014-01-21 12:38:43.090964 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:38:43.090971 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:03.118475 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:04.582335 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:05.219742 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:09.207392 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274015424 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x58b7080 =
con 0x301c8e0
2014-01-21 12:39:09.207437 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:39:09.207446 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:33.545457 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:35.002865 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:40.033516 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274039682 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1efb6900 =
con 0x301c8e0
2014-01-21 12:39:40.033579 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:39:40.033589 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:40.094395 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274064242 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2c3eb200 =
con 0x301c8e0
2014-01-21 12:39:40.094423 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:39:40.094429 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:39:44.208521 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274088941 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x156a5c80 =
con 0x301c8e0
2014-01-21 12:39:44.208548 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:39:44.208553 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:05.240497 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:05.251799 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:05.801058 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:09.999942 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274113165 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x272a3e80 =
con 0x301c8e0
2014-01-21 12:40:09.999972 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:40:09.999979 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:31.794337 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:33.334604 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:34.603958 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274137243 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2ff76b80 =
con 0x301c8e0
2014-01-21 12:40:34.603986 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:40:34.603992 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:54.560978 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:40:58.383452 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274161478 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23493e80 =
con 0x301c8e0
2014-01-21 12:40:58.383497 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:40:58.383506 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:02.460721 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274186052 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x15768280 =
con 0x301c8e0
2014-01-21 12:41:02.460767 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:41:02.460776 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:21.159561 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:22.128066 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:29.339218 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274210127 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x21d62300 =
con 0x301c8e0
2014-01-21 12:41:29.339246 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:41:29.339252 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:49.615961 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:50.434930 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:41:55.499448 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274234473 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x29588000 =
con 0x301c8e0
2014-01-21 12:41:55.499476 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:41:55.499482 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:16.531519 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:17.687598 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:18.704302 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274258965 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x8f69e00 =
con 0x301c8e0
2014-01-21 12:42:18.704336 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:42:18.704342 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:44.306788 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:45.293560 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274283130 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x29f71b80 =
con 0x301c8e0
2014-01-21 12:42:45.293604 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:42:45.293613 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:42:52.159900 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274307291 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1a438280 =
con 0x301c8e0
2014-01-21 12:42:52.159946 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:42:52.159956 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:12.721369 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:13.353255 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:18.297851 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274331541 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x739da00 =
con 0x301c8e0
2014-01-21 12:43:18.297879 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:43:18.297885 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:21.597964 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274355712 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x25a87d00 =
con 0x301c8e0
2014-01-21 12:43:21.598010 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:43:21.598019 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:38.367001 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:39.506520 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:43:40.445848 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:01.185559 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:05.364080 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274379990 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1e13f080 =
con 0x301c8e0
2014-01-21 12:44:05.364108 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:44:05.364113 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:09.684515 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274404785 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2394a300 =
con 0x301c8e0
2014-01-21 12:44:09.684545 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:44:09.684551 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:29.145187 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:30.409772 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:51.065857 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:55.631886 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274428959 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1e0efd00 =
con 0x301c8e0
2014-01-21 12:44:55.639824 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:44:55.639833 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:44:59.612749 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274453034 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x5294b00 =
con 0x301c8e0
2014-01-21 12:44:59.612786 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:44:59.612792 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:45:19.247569 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:45:20.461755 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:45:40.729929 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:45:45.539968 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274477315 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x3067b700 =
con 0x301c8e0
2014-01-21 12:45:45.539995 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:45:45.540000 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:09.104222 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:10.286208 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274501392 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xd7f6680 =
con 0x301c8e0
2014-01-21 12:46:10.286239 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:46:10.286245 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:31.695564 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:35.934508 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274525783 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1dbdfa80 =
con 0x301c8e0
2014-01-21 12:46:35.934535 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:46:35.934540 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:39.746151 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274550478 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1e796e00 =
con 0x301c8e0
2014-01-21 12:46:39.746179 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:46:39.746185 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:46:59.201204 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:00.445592 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:26.019461 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:26.980742 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274574866 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x28e7bc00 =
con 0x301c8e0
2014-01-21 12:47:26.980777 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:47:26.980784 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:33.853432 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274599161 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1d01df00 =
con 0x301c8e0
2014-01-21 12:47:33.853460 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:47:33.853465 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:54.783141 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:55.279268 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:47:58.999101 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274623445 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2088fa80 =
con 0x301c8e0
2014-01-21 12:47:58.999128 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:47:58.999134 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:23.943261 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:25.132931 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:29.807202 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274648153 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x515e900 =
con 0x301c8e0
2014-01-21 12:48:29.807231 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:48:29.807238 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:29.808135 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274672335 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x289edf00 =
con 0x301c8e0
2014-01-21 12:48:29.808165 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:48:29.808171 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:34.557747 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274696616 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x166c7580 =
con 0x301c8e0
2014-01-21 12:48:34.557777 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:48:34.557783 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:55.466204 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:55.466374 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:55.964376 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:48:59.634624 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274720918 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2803f300 =
con 0x301c8e0
2014-01-21 12:48:59.634668 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:48:59.634677 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:03.833361 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274744991 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x16405280 =
con 0x301c8e0
2014-01-21 12:49:03.833405 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:49:03.833414 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:21.130148 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:22.298940 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:23.414053 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:36.000513 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274769620 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x18bfc600 =
con 0x301c8e0
2014-01-21 12:49:36.000541 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:49:36.000546 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:53.071774 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:49:54.311747 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:50:18.132151 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:50:22.070256 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274794003 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0xdff1680 =
con 0x301c8e0
2014-01-21 12:50:22.070286 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:50:22.070292 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:50:26.000276 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274818200 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x19a87a80 =
con 0x301c8e0
2014-01-21 12:50:26.000320 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:50:26.000329 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:50:45.721502 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:50:46.789465 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:12.707215 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:13.990985 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274842736 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x234b5a00 =
con 0x301c8e0
2014-01-21 12:51:13.991014 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:51:13.991020 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:21.553390 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274866939 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x16256b80 =
con 0x301c8e0
2014-01-21 12:51:21.553418 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:51:21.553424 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:42.479953 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:43.097334 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:51:46.940050 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274891133 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2433e900 =
con 0x301c8e0
2014-01-21 12:51:46.940079 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:51:46.940085 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:09.372953 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:10.919483 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:12.146253 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274915549 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1b72fd00 =
con 0x301c8e0
2014-01-21 12:52:12.146284 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:52:12.146290 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:33.304222 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:37.977868 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274940272 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x172ec100 =
con 0x301c8e0
2014-01-21 12:52:37.977897 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:52:37.977902 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:41.746116 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274964756 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2ab5e680 =
con 0x301c8e0
2014-01-21 12:52:41.746145 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:52:41.746151 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:52:59.745728 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:53:01.357609 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:53:02.659803 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:53:28.917455 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:53:30.101601 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 274989169 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1512d000 =
con 0x301c8e0
2014-01-21 12:53:30.101630 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:53:30.101636 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:53:42.666665 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275013377 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x202e6180 =
con 0x301c8e0
2014-01-21 12:53:42.666722 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:53:42.666728 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:00.889226 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:02.112789 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:24.445887 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:28.083024 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275038244 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x51e0c80 =
con 0x301c8e0
2014-01-21 12:54:28.083053 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:54:28.083058 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:32.669030 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275062315 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x24e1a580 =
con 0x301c8e0
2014-01-21 12:54:32.669075 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:54:32.669084 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:51.737360 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:54:52.973578 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:55:12.663760 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:55:17.259225 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275086881 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x15987080 =
con 0x301c8e0
2014-01-21 12:55:17.259256 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:55:17.259262 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:55:21.528926 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275111100 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1e21f080 =
con 0x301c8e0
2014-01-21 12:55:21.528954 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:55:21.528960 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:55:40.680841 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:55:41.918032 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:02.271516 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:07.069396 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275135320 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x24456180 =
con 0x301c8e0
2014-01-21 12:56:07.069423 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:56:07.069429 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:10.936449 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275159391 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2b7a6180 =
con 0x301c8e0
2014-01-21 12:56:10.936499 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:56:10.936508 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:29.493354 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:30.466862 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:56:56.555393 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:01.326269 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275183971 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x52d8280 =
con 0x301c8e0
2014-01-21 12:57:01.326297 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:57:01.326302 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:04.926495 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275208402 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2004a580 =
con 0x301c8e0
2014-01-21 12:57:04.926539 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:57:04.926548 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:23.512244 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:24.536348 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:50.189644 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:51.490669 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275232627 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x10475500 =
con 0x301c8e0
2014-01-21 12:57:51.490699 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:57:51.490705 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:57:58.398306 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275256697 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x26cff080 =
con 0x301c8e0
2014-01-21 12:57:58.398335 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:57:58.398341 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:18.692241 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:19.240814 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:23.672852 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275280917 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x15d81900 =
con 0x301c8e0
2014-01-21 12:58:23.672881 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:58:23.672887 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:27.724114 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275305352 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1cb90c80 =
con 0x301c8e0
2014-01-21 12:58:27.724143 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:58:27.724149 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:45.450467 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:46.721492 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:58:47.695072 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:13.155603 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:14.388980 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275329581 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x297a9e00 =
con 0x301c8e0
2014-01-21 12:59:14.389008 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:59:14.389013 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:21.350523 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275353812 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1c7aa300 =
con 0x301c8e0
2014-01-21 12:59:21.350552 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:59:21.350557 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:41.494623 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:42.125603 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:47.101839 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275378202 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x1b519180 =
con 0x301c8e0
2014-01-21 12:59:47.101868 7fa5fbe21700  0 mon.osd152@0(electing) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:59:47.101874 7fa5fbe21700 10 =
mon.osd152@0(electing).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 12:59:51.135899 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275402483 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x2b1dd500 =
con 0x301c8e0
2014-01-21 12:59:51.135929 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 12:59:51.135935 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:09.221660 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:10.795320 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:12.082615 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:23.919564 7fa5fbe21700  1 -- 10.193.207.130:6789/0 <=3D=3D=
 mon.2 10.194.0.68:6789/0 275427408 =3D=3D=3D=3D =
forward(mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 caps =
allow *) to leader v1 =3D=3D=3D=3D 326+0+0 (2979896460 0 0) 0x23ec6180 =
con 0x301c8e0
2014-01-21 13:00:23.919609 7fa5fbe21700  0 mon.osd152@0(leader) e1 =
handle_command mon_command({"prefix": "osd set", "key": "noin"} v 0) v1
2014-01-21 13:00:23.919618 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:42.945430 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936
2014-01-21 13:00:44.239739 7fa5fbe21700 10 =
mon.osd152@0(leader).paxosservice(osdmap 133136..134893) dispatch =
mon_command({"prefix": "osd set", "key": "noin"} v 0) v1 from =
client.757016 10.193.207.130:0/1054936

--Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"


Thanks,
Guang

On Jan 21, 2014, at 12:35 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> On Sun, 19 Jan 2014, Guang wrote:
>> Thanks Sage.
>>=20
>> I just captured part of the log (it was fast growing), the process =
did=20
>> not hang but I saw the same pattern repeatedly. Should I increase the=20=

>> log level and send over email (it constantly reproduced)?
>=20
> Sure!  A representative fragment of the repeating fragment shoudl be=20=

> enough.
>=20
> s
>>=20
>> Thanks,
>> Guang
>>=20
>> On Jan 18, 2014, at 12:05 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>>=20
>>> On Fri, 17 Jan 2014, Guang wrote:
>>>> Thanks Sage.
>>>>=20
>>>> I further narrow down the problem to #any command using paxos =
service would hang#, following are details:
>>>>=20
>>>> 1. I am able to run ceph status / osd dump, etc., however, the =
result are out of date (though I stopped all OSDs, it does not reflect =
in ceph status report).
>>>>=20
>>>> -bash-4.1$ sudo ceph -s
>>>> cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
>>>>  health HEALTH_WARN 2797 pgs degraded; 107 pgs down; 7503 pgs =
peering; 917 pgs recovering; 6079 pgs recovery_wait; 2957 pgs stale; =
7771 pgs stuck inactive; 2957 pgs stuck stale; 16567 pgs stuck unclean; =
recovery 54346804/779462977 degraded (6.972%); 9/259724199 unfound =
(0.000%); 2 near full osd(s); 57/751 in osds are down; =
noout,nobackfill,norecover,noscrub,nodeep-scrub flag(s) set
>>>>  monmap e1: 3 mons at =
{osd151=3D10.194.0.68:6789/0,osd152=3D10.193.207.130:6789/0,osd153=3D10.19=
3.207.131:6789/0}, election epoch 123278, quorum 0,1,2 =
osd151,osd152,osd153
>>>>  osdmap e134893: 781 osds: 694 up, 751 in
>>>>   pgmap v2388518: 22203 pgs: 26 inactive, 14 active, 79 =
stale+active+recovering, 5020 active+clean, 242 stale, 4352 =
active+recovery_wait, 616 stale+active+clean, 177 =
active+recovering+degraded, 6714 peering, 925 =
stale+active+recovery_wait, 86 down+peering, 1547 active+degraded, 32 =
stale+active+recovering+degraded, 648 stale+peering, 21 =
stale+down+peering, 239 stale+active+degraded, 651 =
active+recovery_wait+degraded, 30 remapped+peering, 151 =
stale+active+recovery_wait+degraded, 4 stale+remapped+peering, 629 =
active+recovering; 79656 GB data, 363 TB used, 697 TB / 1061 TB avail; =
54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%)
>>>>  mdsmap e1: 0/0/1 up
>>>>=20
>>>> 2. If I run a command which uses paxos, the command will hang =
forever, this includes, ceph osd set noup (and also including those =
commands osd send to monitor when being started (create-or-add)).
>>>>=20
>>>> I attached the corresponding monitor log (it is like a bug).
>>>=20
>>> I see the osd set command coming through, but it arrives while paxos =
is=20
>>> converging and the log seems to end before the mon would normally =
process=20
>>> te delayed messages.  Is there a reason why the log fragment you =
attached=20
>>> ends there, or did the process hang or something?
>>>=20
>>> Thanks-
>>> sage
>>>=20
>>>> I=20
>>>>=20
>>>> On Jan 17, 2014, at 1:35 AM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
>>>>=20
>>>>> Hi Guang,
>>>>>=20
>>>>> On Thu, 16 Jan 2014, Guang wrote:
>>>>>> I still have bad the luck to figure out what is the problem =
making authentication failure, so in order to get the cluster back, I =
tried:
>>>>>> 1. stop all daemons (mon & osd)
>>>>>> 2. change the configuration to disable cephx
>>>>>> 3. start mon daemons (3 in total)
>>>>>> 4. start osd daemon one by one
>>>>>>=20
>>>>>> After finishing step 3, the cluster can be reachable ('ceph -s' =
give results):
>>>>>> -bash-4.1$ sudo ceph -s
>>>>>> cluster b9cb3ea9-e1de-48b4-9e86-6921e2c537d2
>>>>>> health HEALTH_WARN 2797 pgs degraded; 107 pgs down; 7503 pgs =
peering; 917 pgs recovering; 6079 pgs recovery_wait; 2957 pgs stale; =
7771 pgs stuck inactive; 2957 pgs stuck stale; 16567 pgs stuck unclean; =
recovery 54346804/779462977 degraded (6.972%); 9/259724199 unfound =
(0.000%); 2 near full osd(s); 57/751 in osds are down; =
noout,nobackfill,norecover,noscrub,nodeep-scrub flag(s) set
>>>>>> monmap e1: 3 mons at =
{osd151=3D10.194.0.68:6789/0,osd152=3D10.193.207.130:6789/0,osd153=3D10.19=
3.207.131:6789/0}, election epoch 106022, quorum 0,1,2 =
osd151,osd152,osd153
>>>>>> osdmap e134893: 781 osds: 694 up, 751 in
>>>>>>  pgmap v2388518: 22203 pgs: 26 inactive, 14 active, 79 =
stale+active+recovering, 5020 active+clean, 242 stale, 4352 =
active+recovery_wait, 616 stale+active+clean, 177 =
active+recovering+degraded, 6714 peering, 925 =
stale+active+recovery_wait, 86 down+peering, 1547 active+degraded, 32 =
stale+active+recovering+degraded, 648 stale+peering, 21 =
stale+down+peering, 239 stale+active+degraded, 651 =
active+recovery_wait+degraded, 30 remapped+peering, 151 =
stale+active+recovery_wait+degraded, 4 stale+remapped+peering, 629 =
active+recovering; 79656 GB data, 363 TB used, 697 TB / 1061 TB avail; =
54346804/779462977 degraded (6.972%); 9/259724199 unfound (0.000%)
>>>>>> mdsmap e1: 0/0/1 up
>>>>>> (at this point, all OSDs should be down).
>>>>>>=20
>>>>>> When I tried to start OSD daemon, the starting script got hang, =
and the process hang is:
>>>>>> root      80497  80496  0 08:18 pts/0    00:00:00 python =
/usr/bin/ceph --name=3Dosd.22 =
--keyring=3D/var/lib/ceph/osd/ceph-22/keyring osd crush create-or-move =
-- 22 0.40 root=3Ddefault host=3Dosd173
>>>>>>=20
>>>>>> When I strace the starting script, I got the following traces =
(process 75873 is the above process), it failed with futex and then do a =
infinite loop:
>>>>>> select(0, NULL, NULL, NULL, {0, 16000}) =3D 0 (Timeout)
>>>>>> Any idea what might trigger this?
>>>>>=20
>>>>> It is hard to tell from the strace what is going on from this.  Do =
you see=20
>>>>> that the OSDs are booting in ceph.log (or ceph -w output)?  If =
not, I=20
>>>>> would look at the osd daemon log for clues.  You may need to turn =
up=20
>>>>> debugging to see (ceph daemon osd.NNN config set debug_osd 20 to =
adjust=20
>>>>> the level on the running daemon).
>>>>>=20
>>>>> If they are booting, it is mostly a matter of letting it recover =
and come=20
>>>>> up.  We have seen patterns where configuration or network issues =
have let=20
>>>>> the system bury itself under a series of osdmap updates.  If you =
see that=20
>>>>> in the log when you turn up debugging, or see the osds going up =
and down=20
>>>>> when you try to bring the cluster up, that could be what is going =
on.  A=20
>>>>> strategy that has worked there is to let all the osds catch up on =
their=20
>>>>> maps before trying to peer and join the cluster.  To do that, =
'ceph osd=20
>>>>> set noup' (which prevents the osds from joining), wait for the =
ceph-osd=20
>>>>> processes to stop chewing on maps (watch the cpu utilization in =
top), and=20
>>>>> once they are all ready 'ceph osd unset noup' and let them join =
and peer=20
>>>>> all at once.
>>>>>=20
>>>>> sage
>>>>>=20
>>>>>>=20
>>>>>> =3D=3D=3D=3D=3D=3D=3D STRACE (PARTIAL) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=20
>>>>>> [pid 75873] futex(0xf707a0, FUTEX_WAIT_PRIVATE, 0, NULL =
<unfinished ...>
>>>>>> [pid 75878] mmap(NULL, 134217728, PROT_NONE, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) =3D 0x7f5da6529000
>>>>>> [pid 75878] munmap(0x7f5da6529000, 28143616) =3D 0
>>>>>> [pid 75878] munmap(0x7f5dac000000, 38965248) =3D 0
>>>>>> [pid 75878] mprotect(0x7f5da8000000, 135168, =
PROT_READ|PROT_WRITE) =3D 0
>>>>>> [pid 75878] futex(0xf707a0, FUTEX_WAKE_PRIVATE, 1) =3D 1
>>>>>> [pid 75873] <... futex resumed> )       =3D 0
>>>>>> [pid 75873] futex(0xdd3cb0, FUTEX_WAIT_PRIVATE, 0, NULL =
<unfinished ...>
>>>>>> [pid 75878] futex(0xdd3cb0, FUTEX_WAKE_PRIVATE, 1 <unfinished =
...>
>>>>>> [pid 75873] <... futex resumed> )       =3D -1 EAGAIN (Resource =
temporarily unavailable)
>>>>>> [pid 75878] <... futex resumed> )       =3D 0
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 1000} <unfinished =
...>
>>>>>> [pid 75878] rt_sigprocmask(SIG_BLOCK, ~[RTMIN RT_1], [], 8) =3D 0
>>>>>> [pid 75878] mmap(NULL, 10489856, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =3D 0x7f5dadb28000
>>>>>> [pid 75878] mprotect(0x7f5dadb28000, 4096, PROT_NONE) =3D 0
>>>>>> [ omit some entries?]
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 16000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 32000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 =
(Timeout)
>>>>>> [pid 75873] select(0, NULL, NULL, NULL, {0, 50000}) =3D 0 =
(Timeout)
>>>>>>=20
>>>>>>=20
>>>>>> Thanks,
>>>>>> Guang
>>>>>>=20
>>>>>> On Jan 15, 2014, at 5:54 AM, Guang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org> wrote:
>>>>>>=20
>>>>>>> Thanks Sage.
>>>>>>>=20
>>>>>>> -bash-4.1$ sudo ceph --admin-daemon =
/var/run/ceph/ceph-mon.osd151.asok mon_status
>>>>>>> { "name": "osd151",
>>>>>>> "rank": 2,
>>>>>>> "state": "electing",
>>>>>>> "election_epoch": 85469,
>>>>>>> "quorum": [],
>>>>>>> "outside_quorum": [],
>>>>>>> "extra_probe_peers": [],
>>>>>>> "sync_provider": [],
>>>>>>> "monmap": { "epoch": 1,
>>>>>>>   "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>>>>>>>   "modified": "0.000000",
>>>>>>>   "created": "0.000000",
>>>>>>>   "mons": [
>>>>>>>         { "rank": 0,
>>>>>>>           "name": "osd152",
>>>>>>>           "addr": "10.193.207.130:6789\/0"},
>>>>>>>         { "rank": 1,
>>>>>>>           "name": "osd153",
>>>>>>>           "addr": "10.193.207.131:6789\/0"},
>>>>>>>         { "rank": 2,
>>>>>>>           "name": "osd151",
>>>>>>>           "addr": "10.194.0.68:6789\/0"}]}}
>>>>>>>=20
>>>>>>> And:
>>>>>>>=20
>>>>>>> -bash-4.1$ sudo ceph --admin-daemon =
/var/run/ceph/ceph-mon.osd151.asok quorum_status
>>>>>>> { "election_epoch": 85480,
>>>>>>> "quorum": [
>>>>>>>     0,
>>>>>>>     1,
>>>>>>>     2],
>>>>>>> "quorum_names": [
>>>>>>>     "osd151",
>>>>>>>     "osd152",
>>>>>>>     "osd153"],
>>>>>>> "quorum_leader_name": "osd152",
>>>>>>> "monmap": { "epoch": 1,
>>>>>>>   "fsid": "b9cb3ea9-e1de-48b4-9e86-6921e2c537d2",
>>>>>>>   "modified": "0.000000",
>>>>>>>   "created": "0.000000",
>>>>>>>   "mons": [
>>>>>>>         { "rank": 0,
>>>>>>>           "name": "osd152",
>>>>>>>           "addr": "10.193.207.130:6789\/0"},
>>>>>>>         { "rank": 1,
>>>>>>>           "name": "osd153",
>>>>>>>           "addr": "10.193.207.131:6789\/0"},
>>>>>>>         { "rank": 2,
>>>>>>>           "name": "osd151",
>>>>>>>           "addr": "10.194.0.68:6789\/0"}]}}
>>>>>>>=20
>>>>>>>=20
>>>>>>> The election has been finished with leader selected from the =
above status.
>>>>>>>=20
>>>>>>> Thanks,
>>>>>>> Guang
>>>>>>>=20
>>>>>>> On Jan 14, 2014, at 10:55 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> =
wrote:
>>>>>>>=20
>>>>>>>> On Tue, 14 Jan 2014, GuangYang wrote:
>>>>>>>>> Hi ceph-users and ceph-devel,
>>>>>>>>> I came across an issue after restarting monitors of the =
cluster, that authentication fails which prevents running any ceph =
command.
>>>>>>>>>=20
>>>>>>>>> After we did some maintenance work, I restart OSD, however, I =
found that the OSD would not join the cluster automatically after being =
restarted, though TCP dump showed it had already sent messenger to =
monitor telling add me into the cluster.
>>>>>>>>>=20
>>>>>>>>> So that I suspected there might be some issues of monitor and =
I restarted monitor one by one (3 in total), however, after restarting =
monitors, all ceph command would fail saying authentication timeout?
>>>>>>>>>=20
>>>>>>>>> 2014-01-14 12:00:30.499397 7fc7f195e700  0 monclient(hunting): =
authenticate timed out after 300
>>>>>>>>> 2014-01-14 12:00:30.499440 7fc7f195e700  0 librados: =
client.admin authentication error (110) Connection timed out
>>>>>>>>> Error connecting to cluster: Error
>>>>>>>>>=20
>>>>>>>>> Any idea why such error happened (restarting OSD would result =
in the same error)?
>>>>>>>>>=20
>>>>>>>>> I am thinking the authentication information is persisted in =
mon local disk and is there a chance those data got corrupted?
>>>>>>>>=20
>>>>>>>> That sounds unlikely, but you're right that the core problem is =
with the=20
>>>>>>>> mons.  What does=20
>>>>>>>>=20
>>>>>>>> ceph daemon mon.`hostname` mon_status
>>>>>>>>=20
>>>>>>>> say?  Perhaps they are not forming a quorum and that is what is =
preventing=20
>>>>>>>> authentication.
>>>>>>>>=20
>>>>>>>> sage
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe =
ceph-devel" in
>>>>>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>>>> More majordomo info at  =
http://vger.kernel.org/majordomo-info.html
>>>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>=20
>>>>=20
>>>=20
>>=20
>>=20
>=20


--Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--Apple-Mail=_CCF90676-B6FB-4698-8B4B-BF86904B6F96--
