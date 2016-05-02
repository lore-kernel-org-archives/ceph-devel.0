From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: s3website 404 behaviour
Date: Mon, 02 May 2016 15:53:09 +0200
Message-ID: <87eg9kva62.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43637 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcEBNxe (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 2 May 2016 09:53:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: robbat2@gentoo.org

Hi

After setting up ceph.conf values resembling:

rgw dns name =3D myhost.domain.com (eg)
rgw enable static website =3D true
rgw dns s3website name =3D mywebsite.domain.com

and creating buckets and objects with `public-read` canned acls, via th=
e
following code (assume conn is s3connection object returned by boto):

website_bucket =3D conn.create_bucket("s3website",policy=3D'public-read=
')
index_key =3D website_bucket.new_key('index.html')
index_key.content_type =3D 'text/html'
index_key.set_contents_from_filename('index.html',policy=3D'public-read=
')

error_key =3D website_bucket.new_key('error.html')
error_key.content_type =3D 'text/html'
error_key.set_contents_from_filename('error.html',policy=3D'public-read=
')

foo_key =3D website_bucket.new_key('foo.html')
foo_key.content_type =3D 'text/html'
foo_key.set_contents_from_filename('foo.html',policy=3D'public-read')

website_bucket.configure_website('index.html','error.html')
website_bucket.get_website_configuration()
# returns
# {'WebsiteConfiguration': {'ErrorDocument': {'Key': 'error.html'}, 'In=
dexDocument': {'Suffix': 'index.html'}}}


Calling urls like s3website.mywebsite.domain.com works as
expected, links from index page are processed correctly, and accessing
something like s3website.<website-domain>/foo.html also works as
expected.

However the behaviour when a 404 is encountered in the bucket
seems erratic, for eg accessing:
s3website.mywebsite.domain.com/nonexistant.html

the browser sees a 200 OK and just does a download of an empty file, rg=
w
actually returns a 404 here[1]. I haven't checked the behavior on S3
yet, Is there something else that needs to be set in bucket website
configuration, or is this something RGW is doing wrong at the moment?

[1]: https://gist.github.com/theanalyst/891781582ddc454bafdc5ef7d075ec7=
a

--
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Nort=
on, HRB 21284 (AG N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
