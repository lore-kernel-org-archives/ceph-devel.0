From: Rutger ter Borg <rutger@terborg.net>
Subject: [rados] Asynchronous operations
Date: Wed, 27 Jun 2012 09:32:03 +0200
Message-ID: <jsecti$m2u$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51073 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab2F0HcR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Jun 2012 03:32:17 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1SjmjU-0003aY-7S
	for ceph-devel@vger.kernel.org; Wed, 27 Jun 2012 09:32:12 +0200
Received: from 233-250-103-145.static.glaslokaal.nl ([145.103.250.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 09:32:12 +0200
Received: from rutger by 233-250-103-145.static.glaslokaal.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jun 2012 09:32:12 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Dear list,

I'm currently writing a Boost.Asio-like interface to librados.hpp. Most 
things are working like expected, and some things I couldn't figure out 
from the available docs and code. I have itemized a couple of questions 
below.

* to avoid allocations done by rados, I'm currently using 
buffer::create_static() for both reads and writes. I suppose this is ok?

* suppose you have the following code example

boost::asio::io_service ios;
pool pool( "some pool", ios );

std::string some_data( "this is an example string of data" );
pool.async_write_object_at( "hello", 0, boost::asio::buffer( some_data 
), &done );

ios.run();

with respect to this interface, I have the following questions:

a) the IoCtx's synchronous read() and write() functions return the 
number of bytes read and written; is there a way to get to this number 
from AioCompletion? I would like to define the function signature for 
the callback handler (see 'done' in the example above) something like

void( const boost::system::error_code&, std::size_t )

where the second argument would be the number of bytes transferred.

b) is it possible to cancel outstanding asynchronous operations? I.e., 
have the possibility to implement something like

pool.cancel();

?

TIA,
Regards,

Rutger



