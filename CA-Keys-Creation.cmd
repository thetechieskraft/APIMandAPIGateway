:: Create root certs
:: Please use your own custom domain name as shivazuredemo.com is only used as a reference

	openssl genrsa -des3 -out shivazuredemo.key 4096

	openssl req -x509 -new -nodes -key shivazuredemo.key -sha256 -days 1825 -out shivazuredemo.pem

:: Create certs for APIM proxy, portal and management

	openssl genrsa -out api.shivazuredemo.com.key 2048

:: make sure to private custom domain name such as api.shivazuredemo.com, for CN name

	openssl req -new -key api.shivazuredemo.com.key -out api.shivazuredemo.com.csr

	openssl x509 -req -in api.shivazuredemo.com.csr -CA shivazuredemo.pem -CAkey shivazuredemo.key -CAcreateserial -out api.shivazuredemo.com.crt -days 1825 -sha256

	openssl pkcs12 -export -out api.shivazuredemo.com.pfx -inkey api.shivazuredemo.com.key -in api.shivazuredemo.com.crt

:: make sure to private custom domain name such as portal.shivazuredemo.com, for CN name

	openssl genrsa -out portal.shivazuredemo.com.key 2048

	openssl req -new -key portal.shivazuredemo.com.key -out portal.shivazuredemo.com.csr

	openssl x509 -req -in portal.shivazuredemo.com.csr -CA shivazuredemo.pem -CAkey shivazuredemo.key -CAcreateserial -out portal.shivazuredemo.com.crt -days 1825 -sha256

	openssl pkcs12 -export -out portal.shivazuredemo.com.pfx -inkey portal.shivazuredemo.com.key -in portal.shivazuredemo.com.crt

:: make sure to private custom domain name such as management.shivazuredemo.com, for CN name

	openssl genrsa -out management.shivazuredemo.com.key 2048
	
	openssl req -new -key management.shivazuredemo.com.key -out management.shivazuredemo.com.csr

	openssl x509 -req -in management.shivazuredemo.com.csr -CA shivazuredemo.pem -CAkey shivazuredemo.key -CAcreateserial -out management.shivazuredemo.com.crt -days 1825 -sha256

	openssl pkcs12 -export -out management.shivazuredemo.com.pfx -inkey management.shivazuredemo.com.key -in management.shivazuredemo.com.crt
