From: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Subject: Re: Cache Tiering Investigation and Potential Patch
Date: Wed, 25 Nov 2015 13:38:52 -0700
Message-ID: <CAANLjFrwGJNoSObrRcRbpRpsqdQwH6xemetRBvrWO7PrS4cerw@mail.gmail.com>
References: <3196669f.9Ro.9Gf.11.jZLaYO@mailjet.com>
	<alpine.DEB.2.00.1511250936470.11017@cobra.newdream.net>
	<2f99090c.9Ro.9Gf.24.jZU57B@mailjet.com>
	<alpine.DEB.2.00.1511251137390.11017@cobra.newdream.net>
	<d2bef9c0.9Ro.9Gf.1R.jZVKGC@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <d2bef9c0.9Ro.9Gf.1R.jZVKGC-ImYt9qTNe79BDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I think if it is not too much, we would like N out of M.

I don't know specifically about only building the one package, but I
build locally with make to shake out any syntax bugs, then I run
make-debs.sh which takes about 10-15 minutes to build to install on my
test cluster. It still builds more packages than I need. Be sure you
have ccache installed and configured, that helps a lot. I'm still
trying to figure out the best way to build too.




-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWVhxXCRDmVDuy+mK58QAAWyMP/1rQgDr1lAR8ra2y16zv
0S73cJdxZ/YlbILThDobtQw487YIZMg0vYNZGeYU1//KtZjiAQ2izv1ZLIjz
3Xemn+hx79aWL3uHFTbiK69HsbeURSeyS99g+8rGxc0X7gXrDhqhbThT+QqY
N3osIEGqVCVWftAnj/ttMd6+CM7x2cxMtM/ALDQTDFu7DzUKLWs7fqtdX3uh
MeoB2pW9ZQE4YSLs0JhmRanhqjt0ygJ4R73Uge+fnqibM7jquchdgj1X9GHG
M/w4n4n5Tw6GUfIX2ivpnJuMyKyaeI0+2rSMyfaHwI714YqBNRRga7MMzmvH
a5NHVgjoWkys3cnIjblcTzgp+Un+av7tZ8sHXJjvJxu7wcGvWhUtwogn3LMN
KNzN+5Ae0kOBvgXvQ0a8hbvOW3tMkfzEVo2s7UhX7ZthAy11toVV27E50pJj
zeTJqMBWRn8Q+qn0k3mfzciTYoFZN7TmSoK+BWUajhm0dA6q9ce99Huz5lIu
+FpcqfLhA9//E4eYRYaUGRDuhcxdaSS4PbZzHPnKlEZYVFHYq3kYWRYET0I9
N9S8jknW+vIJnMiVwKfalz5poX9OCgMvJwXtWCzxZi0scwU6iM4GvpigcgVO
Gk0DlEQG+94+giGLqRf67R5w9kdlB6SE7n50tSNgzDUQw0NjadSoi2YDkU3q
O/Zx
=IwXm
-----END PGP SIGNATURE-----
