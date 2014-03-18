From: Vipul Nayyar <nayyar_vipul@yahoo.com>
Subject: Re: [GSOC] Google Storage API Project
Date: Wed, 19 Mar 2014 03:43:30 +0800 (SGT)
Message-ID: <1395171810.80796.YahooMailNeo@web194904.mail.sg3.yahoo.com>
References: <1393874910.26569.YahooMailNeo@web194906.mail.sg3.yahoo.com> <1393875396.14447.YahooMailNeo@web194906.mail.sg3.yahoo.com> <CF3A2C17.2701A%ian.colle@inktank.com>
Reply-To: Vipul Nayyar <nayyar_vipul@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm24-vm3.bullet.mail.sg3.yahoo.com ([106.10.151.82]:22189 "EHLO
	nm24-vm3.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbaCRTnc convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Mar 2014 15:43:32 -0400
In-Reply-To: <CF3A2C17.2701A%ian.colle@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Colle <ian.colle@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "yehuda@inktank.com" <yehuda@inktank.com>
Cc: "patrick@inktank.com" <patrick@inktank.com>

Hi Ian,

Sorry for the late reply. Thanks for the links that you gave. I've gone=
 through them and I'm currently studying the Google Storage API in orde=
r to figure out it's implementation. I've also gone through the source =
code of libs3 in the ceph repo. Due to the excellent clarity of the cod=
e, I was able to easily understand the basic flow of how things are wor=
king with respect to the S3. Following are the methods that will be imp=
lemented under the Google API.
=A0
GET Service :=A0Lists all of the buckets in a specified project.
DELETE Bucket
GET Bucket
HEAD Bucket
PUT Bucket
DELETE Object
GET Object
HEAD Object
POST Object
PUT Object=A0=A0

The format of the HTTP headers that need to be sent regarding each meth=
od have been clearly given in the Google documentation which is quite s=
imilar to the S3 API. Regarding the Authorization part, every request t=
hat needs to be authorized must have a=A0request header that contains a=
n authentication string. This authentication string can be extracted wi=
th the help of Oauth. As written in the project description, that authe=
ntication will take up the majority of the project's time, hence I'd li=
ke to know the challenges regarding this beforehand since the Google do=
cs focus more on the Oauth authentication from the user's perspective.

=46Inally, since only a few days are left for proposal submission deadl=
ine, so I'll fast track my proposal preparation based on your feedback =
and guidance.

Regards
Vipul Nayyar=A0
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
