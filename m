From: Sage Weil <sage@newdream.net>
Subject: Re: librados api cleanup
Date: Fri, 18 Feb 2011 13:36:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102181334100.13848@cobra.newdream.net>
References: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
 <AANLkTim0kgb3LfhdpxXzjfxZ55eyhfWg1BtZ7RyzusQN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1298255716-1298064851=:13848"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54158 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab1BRVfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 16:35:30 -0500
In-Reply-To: <AANLkTim0kgb3LfhdpxXzjfxZ55eyhfWg1BtZ7RyzusQN@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1102181334180.16662@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1298255716-1298064851=:13848
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1102181334181.16662@cobra.newdream.net>

On Mon, 14 Feb 2011, Colin McCabe wrote:

> On Mon, Feb 14, 2011 at 3:00 PM, Sage Weil <sage@newdream.net> wrote:
> > There are a few problems with the current librados api (at least the C
> > bindings). =A0The main one is that there is an implicit assumption that=
 you
> > can only interact with a single cluster from the same process.
> > rados_initalize() takes argc/argv, allowing you to pass in configuratio=
n
> > options and/or a config file location, and it is assume that is the
> > cluster that is referenced when you open up a pool.
>=20
> One idea would be to have a C API like this:
>=20
> rados_cluster_t ctx;
> rados_initialize(&ctx);
> rados_read_configuration(ctx, "my_ceph_config.conf");
> rados_set_conf("log dir", "/my/log/dir");

How about:

---
/* initialization */
int rados_open(rados_t *cluster);
void rados_close(rados_t cluster);

/* config */
int rados_conf_parse_argv(rados_t cluster, int argc, char **argv);
int rados_conf_readfile(rados_t cluster, const char *path);
int rados_conf_set(rados_t cluster, const char *option, const char *value);
const char *rados_conf_get(rados_t cluster, const char *option);
---

I think the (short term) trick will be supporting this immediately before=
=20
the config refactoring is in place.  Should be possible with a hidden=20
argv vector and the existing internal framework, I think.=20

sage
--557981400-1298255716-1298064851=:13848--
