
bounds = [50,300]; 
spectra = (randi(bounds,357,10)*0.0001) * 10^(-11);
nObs = size(spectra,1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

%The spectra data was collected at evenly-spaced wavelengths, 
%and you know the starting wavelength (λstart), the spacing (λ delta),
%and the number of observation

%Task 1
lambdaEnd = lambdaStart + (nObs -1)* lambdaDelta;
lambda = lambdaStart:lambdaDelta:lambdaEnd;
lambda = lambda';


%Each column of spectra is the spectrum of a different star. 
%The sixth column is the spectrum of star HD 94028.
%Plot the spectra (s) as a function of wavelength (lambda), 
%using log scales on both axes. 

%Task 2 & 7
s = spectra(:, 2);
loglog(lambda, s, ".-");
xlabel("Wavelength");
ylabel("Intensity");

%min function allows two outputs, the second of which is the index at 
%which the minimum value occurred. This index corresponds to the location 
%of the Hydrogen-alpha line. Use idx to index into lambda to find the
%wavelength of the Hydrogen-alpha line. Store the result as lambdaHa (λHa)

%Task 3
[sHa, idx] = min(s);
lambdaHa = lambda(idx);

%The point (lambdaHa,sHa) is the location of the Hydrogen-alpha line.

%Task 4

hold on;
plot(lambdaHa, sHa, "rs", "MarkerSize", 8);

%If you zoom in on the plot, you can see that the wavelength of the
%Hydrogen-alpha line of HD 94028 is 656.62 nm, which is slightly longer 
%than the laboratory value of 656.28 nm.

%Using the Hydrogen-alpha wavelength of the star, 
%you can calculate the redshift factor (the speed of the star 
%relative to the earth) using the formula z=(λHa/656.28)−1. 
%You can then calculate the speed by multiplying the redshift factor 
%by the speed of light (299792.458km/s).

%Task 5
z = (lambdaHa/656.28) - 1;
speed = z*299792.458;

%Having created a live script for finding the redshift, 
%you can easily modify the script to repeat the calculation 
%on any star in the spectra matrix.
%In the previous project, you determined if one star's spectrum 
%was redshifted or blueshifted, and calculated the star’s speed 
%relative to the Earth. In this project, you will calculate all the 
%stars' speed at once. Then you'll create the plot below.
%the spectrum data is extracted for the second star in the matrix spectra. 
%Then lines 3 through 5 calculate the speed based on that data. 
%How would you calculate the speed of all the stars in spectra?

[sHa,idx] = min(spectra);
lambdaHa = lambda(idx);
z = lambdaHa/656.28 - 1;
speed = z*299792.458;

%Notice that speed is now a vector. A positive speed means that the 
%star is moving away from us (redshifted spectrum), and a negative speed 
%means the star is moving towards us (blueshifted spectrum).

%In the next few tasks, you'll plot the spectra of all seven stars 
%using different line properties for redshifted and blueshifted spectra. 
%It is convenient to use a for loop to access each star's data one at time.
%Since you'll use different styles for redshifted and blueshifted spectra, 
%you can use an if statement.
%You'll plot the redshifted spectra using a thick line.

for v = 1:7
    s = spectra(:,v);
    if(speed(v) <= 0)
        loglog(lambda, s, "--");
    elseif speed(v) > 0
        loglog(lambda, s, "LineWidth", 3);
    end
hold on
end
hold off

%You can pass a string array directly to the legend function.
%The string array starnames contains the name of each star in spectra.
starnames = ["HD  30584";"HD  10032";"HD  64191";"HD  5211";
    "HD  56030";"HD  94028"; "SAO102986"];
legend(starnames)

%In the plot, you can use the line styles to identify the stars 
%with redshifted spectra, then look up their names in the legend. 

movaway = starnames (speed> 0);

%If you do not want to differentiate between redshifted and blueshifted 
%spectra, you do not need to use a for loop.

loglog(lambda,spectra);
legend(starnames);


